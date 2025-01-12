(local {: pack : unpack} (require :pact.lib.ruin.enum))
(local {: thread?} (require :pact.lib.ruin.type))

(fn async-wrap [func]
  ;; Wraps given function in a coroutine so it can be suspended by inner awaits.
  ;;
  ;; Returns a function, which when called, creates a coroutine with any given
  ;; arguments, then returns that coroutine. The caller is expected to manage
  ;; at least the initial (coroutine.resume ...) call
  (var future nil)
  (var final-value nil)
  (var first-call-args nil)
  (local function-co (coroutine.create func))

  (fn resume-with-correct-args [thread new-args]
    ;; This is basically an ergonomic flip, we want to be able to call the
    ;; "create thread" function that we return with some arguments to pass to
    ;; the original function we wrapped, but hygenically we don't want to
    ;; continously resume with those arguments. So we store them as
    ;; first-call-args, then eiher resume with them if they exist, or resume
    ;; with any provided (which generally wont happen anyway because we control
    ;; the resume/yield flow)
    (let [args (or first-call-args new-args)
          _ (set first-call-args nil)]
      (coroutine.resume thread (unpack args))))

  (fn awaitable-fn [...]
    (while (= final-value nil)
      (match future
        ;; if there is no future, we should resume
        nil
        (match [(resume-with-correct-args function-co [...])]
          (where [true thread] (= :thread (type thread))) (set future thread)
          [true :info & info] nil
          [true & value] (set final-value value)
          [false err] (error err))
        ;; if we have a future, don't resume the main code coroutine until
        ;; the future has resolved itself.
        future
        (match (coroutine.status future)
          :dead
          (set future nil)
          ;; we have a future, it's not finished, so give up this run
          status
          (coroutine.yield future))))
    (values (unpack final-value)))

  (fn [...]
    (set first-call-args [...])
    (coroutine.create awaitable-fn)))

(fn await-wrap [func argv]
  ;; TODO, should be func ... so we can accurately parse nil? upstream into ruin
  ;; Must be called inside a coroutine.
  ;;
  ;; Must be passed a function that accepts an async callback.
  ;;
  ;; Creates a co-routine that suspends itself after calling the given
  ;; function, and then un-suspends itself after the async callback occurs.
  ;; When it suspends, it returns its own coroutine, which can be treated as a
  ;; spin on a future/promise.
  ;;
  ;; Since the async callback resumes the suspended coroutine, we can check the
  ;; status of that coroutine to get the status of the "promise". When its
  ;; suspended or running, the value isn't resolved, when it's "dead", that
  ;; means the async callback has completed.
  ;;
  ;; This comes together with the second step, that (await ...) *also* suspends
  ;; the main coroutine, when it returns the "promise" to the scheduler. When
  ;; the scheduler sees the promise is resolved, it can resume the main
  ;; workflow coroutine.
  ;;
  ;; Once resumed, the final value can be returned to the main coroutine as if
  ;; it had been a syncronous call.
  ;;
  ;; This could also (probably simplerly) done with an actual {:promise} table
  ;; being passed around but this is a bit of an experiment.
  ; (expect (= :function (type func)) "must be a function")
  (assert (coroutine.running) "must call await inside (async ...)")
  (local co coroutine)
  (var awaited-value nil)

  (fn create-thread [func argv]
    (let [await-co (co.running)
          resolve-future (fn [...]
                           ;; store the return value
                           (set awaited-value (pack ...))
                           ;; kill our future
                           (co.resume await-co))
          _ (table.insert argv resolve-future)
          ;; this *can* throw, which we will rethrow
          ;; nil, x is caught and returned as nil, ex
          ;; any other value is returned as thread, x
          first-return (pack (func (unpack argv)))]
      (match first-return
        ;; assume nil + x is an error internally and we should not proceed
        [nil & rest] (unpack first-return)
        ;; otherwise assume we're ok to "thread"
        ;; now suspend this coroutine, as a future, when the future resumes
        ;; itself, we will terminate and the future will be "dead" at which
        ;; point we know we can resume the main coroutine.
        _ (co.yield await-co (unpack first-return)))))
  (let [await-co (co.create create-thread)
        vals (pack (co.resume await-co func argv))]
    (match vals
      ;; internal error when running function, so behave the same
      [false err] (error err)
      ;; "error like" return, so assume thread failed. Repack values
      ;; and continune on to return them.
      [true nil & rest] (set awaited-value (pack (unpack vals 2)))
      ;; got thread, so we can suspend ourselves
      (where [true thread & rest] (thread? thread)) (co.yield (unpack vals 2)))
    ;; once we're resumed, when the "future" becomes "dead" and the scheduler
    ;; has picked up again, we can return the sticky value set in the thread.
    (values (unpack awaited-value))))

{: async-wrap : await-wrap}
