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

;; TODO Start with calling pen-fn-imagine-evaluating-emacs-lisp/2 from clojure
;; TODO Then implement ieval/m
;; TODO Then implement ilambda/name
;; TODO Then implement ilambda
;; TODO Then implement idefun/name