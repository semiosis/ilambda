(ns ilambda-clj.core)

;; TODO First, implement pen client
;; /home/shane/var/smulliga/source/git/semiosis/pen.el/src/pen-client.el

;; TODO Second, implement ilambda thin client
;; /home/shane/var/smulliga/source/git/semiosis/pen.el/src/ilambda.el

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