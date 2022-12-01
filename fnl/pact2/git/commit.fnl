(import-macros {: use} :pact.lib.ruin.use)

(use {: 'fn* : 'fn+} :pact.lib.ruin.fn
     {: string? : table?} :pact.lib.ruin.type
     enum :pact.lib.ruin.enum
     {: valid-sha?} :pact2.valid
     {:format fmt} string)

(fn* expand-version
  (where [v] (string.match v "^(%d+)$"))
  (.. v ".0.0")
  (where [v] (string.match v "^(%d+%.%d+)$"))
  (.. v ".0")
  (where [v] (string.match v "^(%d+%.%d+%.%d+)$"))
  (.. v)
  (where _)
  (values nil))

;; note: we intentionally don't normalise duplicate sha-attr pairs
;; in the rest of the system incase two tags point to one sha, etc.
(fn* commit
  (where [sha] (valid-sha? sha))
  (commit sha {})
  (where [sha {:tag ?tag :branch ?branch :version ?version}]
         (and (valid-sha? sha)
              (string? (or ?tag ""))
              (string? (or ?branch ""))
              (string? (or ?version ""))))
  {:sha sha :branch ?branch :tag ?tag :version (expand-version ?version)}
  (where _)
  (values nil "commit requires a valid sha and optional table of tag, branch or version"))

(fn ref-line->commit [ref]
  ;; We want to match "<sha> refs/[head|tag]/name".
  ;; Name can have special characters in it such as othes slashes or dashes, etc
  ;;
  ;; Some tags will have ^{} appended, AFAIK these always come in pairs, with a
  ;; "tag" and "peeled tag" (with ^{}). Not all repos/tags have these pairs.
  ;;
  ;; So this function will match either, a tag or peeled tag, but when calcutating
  ;; to solve version constraints, you must either look for duplicate tags names
  ;; with different shas and treat both as valid, or drop the dulpicate that is
  ;; missing the deref indicator (^{}). When checking out the NON deref tag, you
  ;; will end up at the deref'd commit, so future status checks will show that
  ;; the checkout needs updating, even though it is technically equal.
  ;;
  ;; see https://git-scm.com/docs/git-check-ref-format
  ;; Parse *expects* the input to be from `ls-remote --tags --heads url`
  ;; for best results.
  (match (string.match ref "(%x+)%s+refs/(.+)/(.+)")
    (sha :heads name) (commit sha {:branch name})
    (sha :tags name) (match (string.match name "v?(%d+%.%d+%.%d+)")
                       nil (commit sha {:tag name})
                       version (commit sha {:tag name
                                            :version version}))))

{: commit : ref-line->commit}