(ns ilambda-clj.core)

;; TODO First, implement pen client
;; e:$MYGIT/semiosis/pen.el/src/pen-client.el

;; TODO Second, implement ilambda thin client
;; e:$MYGIT/semiosis/pen.el/src/ilambda.el

;; variadic function clojure

;; pr-str quotes a single string (it's like q)
(defn pen-q [& strings]
  (clojure.string/join
   " "
   (map
    (fn [s] (pr-str s))
    strings)))

;; (chomp "fkjldss \nhi\n\n\n  ")
(defn chomp [s]
  ;; remove trailing newlines and whitespace
  (clojure.string/replace s #"\s*$" ""))

(defn pen-eval-string [string]
  (eval (read-string (format "(do %s)" string))))

;; TODO Implement the client before ilambda. I need the prompt functions
;; TODO Start with calling pen-fn-imagine-evaluating-emacs-lisp/2 from clojure
;; TODO Then implement ieval/m
;; TODO Then implement ilambda/name
;; TODO Then implement ilambda
;; TODO Then implement idefun/name


(defun pen-client-generate-functions ()
  (let [(sig-sexps
         (pen-eval-string
          (concat
           "'"
           (chomp
            (pen-sn-basic
             (pen-client-ecmd
              "pene"
              "(pen-list-signatures-for-client)"))))))]

    (dolist (s sig-sexps)
            (let* ((fn-name
                    (->> s
                         (pp/pprint-oneline)
                         (re-replace #"(pf-\\([^ )]*\\).*" "pen-fn-\\1")))
                   (remote-fn-name
                    (replace-regexp-in-string "(\\([^ )]*\\).*" "\\1" (pp-oneline s)))
                   (fn-sym
                    (intern fn-name))
                   (remote-fn-sym
                    (intern remote-fn-name))))
            (args
             (replace-regexp-in-string "^[^ ]* &optional *\\(.*\\))$" "\\1" (pp-oneline s)))
            (arg-list
             (split-string args))
            (arg-list-syms
             (mapcar 'intern arg-list))
            (ilist
             (cons
              'list
              (cl-loop
               for a in arg-list collect
               (pen-eval-string (concat "'(read-string " (pen-q (concat a ": ")) ")")))))

            (eval
             `(cl-defun ,fn-sym ,(append
                                  (pen-eval-string
                                   (if (string-equal args "")
                                     "'()"
                                     (format "'(&optional %s)" args)))
                                  '(&key
                                    no-select-result
                                    include-prompt
                                    no-gen
                                    select-only-match
                                    variadic-var
                                    pretext
                                    prompt-hist-id
                                    inject-gen-start
                                    override-prompt
                                    force-interactive
                              ;; inert for client
                                    client
                                    server))
                         ,(cons 'interactive (list ilist))

                         (let* [(is-interactive
                                 (or (interactive-p)
                                     force-interactive))
                                (pen-script-name
                                 (if (eq 1 (pen-var-value-maybe 'force-n-completions))
                             ;; TODO Force this somehow to do one completion
                             ;; Can't use penf, because it's different.
                                   "penj"
                                   "pena"))
                                (client-do-pen-update
                                 (or
                            ;; H-u -- this doesn't work with some interactive functions, such as (interactive (list (read-string "kjlfdskf")))
                            ;; Can't use current-global-prefix-arg because a vanilla client doesn't necessarily have this
                            ;; (>= (prefix-numeric-value current-global-prefix-arg) 4)
                            ;; C-u 0
                                  (= (prefix-numeric-value current-prefix-arg) 0)
                                  (pen-var-value-maybe 'do-pen-update)))
                          ;; I have to supply prompt-hist-id here as an option
                                (sn-cmd
                                 (if client-do-pen-update
                                   `(pen-client-ecmd ,pen-script-name "-u" "--prompt-hist-id" prompt-hist-id ,,remote-fn-name ,@'arg-list-syms)
                                   `(pen-client-ecmd ,pen-script-name "--prompt-hist-id" prompt-hist-id ,,remote-fn-name ,@'arg-list-syms)))]
                               (if (or server
                                       (not (pen-container-running-p)))
                                 (apply 'remote-fn-sym
                                        (append
                                         (mapcar 'eval 'arg-list-syms)
                                         (list
                                          :no-select-result no-select-result
                                          :include-prompt include-prompt
                                          :no-gen no-gen
                                          :select-only-match select-only-match
                                          :variadic-var variadic-var
                                          :pretext pretext
                                          :prompt-hist-id prompt-hist-id
                                          :inject-gen-start inject-gen-start
                                          :override-prompt override-prompt
                                          :force-interactive is-interactive
                                  ;; inert for client
                                  ;; client
                                  ;; server
                                          )))
                                 (let* ((results (vector2list (json-read-from-string (chomp (eval `(pen-sn-basic ,sn-cmd)))))))
                                       (if is-interactive
                                         (pen-etv
                                          (completing-read ,(concat remote-fn-name ": ") results))
                                         results)))))))))