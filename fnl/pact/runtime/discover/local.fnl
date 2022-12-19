(import-macros {: ruin!} :pact.lib.ruin)
(ruin!)

(use {: 'result->> : 'result-> : 'result-let
      : ok : err} :pact.lib.ruin.result
     Commit :pact.git.commit
     Git :pact.workflow.exec.git
     FS :pact.workflow.exec.fs
     R :pact.lib.ruin.result
     E :pact.lib.ruin.enum
     PubSub :pact.pubsub
     Package :pact.package
     {:format fmt} string
     {:new new-workflow : yield : log} :pact.workflow)

(local DiscoverLocal {})

(fn status-local [repo-path]
  "Fetch commits from local repo, will update repo refs before hand"
  (result-let [_ (log "getting local HEAD")
               HEAD-sha (Git.HEAD-sha repo-path)
               commit (Commit.new HEAD-sha)]
    (log "retrieved HEAD")
    (ok commit)))

(fn detect-kind [repo-path]
  (result-> (log "discovering HEAD commit %s" repo-path)
            (or (FS.absolute-path? repo-path)
                (err (fmt "plugin path must be absolute, got %s" repo-path)))
            (#(if (FS.git-dir? repo-path)
                (status-local repo-path)
                ;; not a git dir, assume its missing, probaly remote at the moment
                ;; so we have no head sha.
                (do
                  (log "no local HEAD")
                  (ok))))))

(fn* new
  (where [id repo-path])
  (new-workflow (fmt "discover-head-commit:%s" id) #(detect-kind repo-path)))

(fn DiscoverLocal.workflow [canonical-set path-prefix]
  (let [;; we only need one packge to work on
        package (E.hd canonical-set)
        ;; but need to propagate results to all in the set
        update-siblings #(E.each (fn [_ p] ($1 p)) canonical-set)
        wf (new package.canonical-id (FS.join-path path-prefix package.install.path))]
    (update-siblings (fn [package]
                       (Package.track-workflow package wf)))
    (wf:attach-handler
      (fn [commit]
        (update-siblings #(do
                           ;; may be nil, for no local checkout, maybe change? TODO
                           (match (R.unwrap commit)
                             c (Package.set-head $ c))
                           (-> $
                               (Package.untrack-workflow wf)
                               (Package.add-event wf commit)
                               (E.set$ :state :unstaged)
                               (PubSub.broadcast (R.ok :head-updated))))))
      (fn [err]
        (update-siblings #(-> $
                              (Package.untrack-workflow wf)
                              (Package.add-event wf err)
                              (E.set$ :text (tostring err))
                              ;; TODO
                              (Package.update-health
                                (Package.Health.failing (fmt "E-9999")))
                              (PubSub.broadcast (R.err :head-updated)))))
      (fn [msg]
        #(-> $
            (Package.add-event wf msg)
            (E.set$ :text msg)
            (PubSub.broadcast :events-changed))))
    wf))

DiscoverLocal