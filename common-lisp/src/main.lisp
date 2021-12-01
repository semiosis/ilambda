(defpackage ilambda
  (:use :cl))
(in-package :ilambda)

(defun main ()
  (my-call-process "tv" nil)
  (format t "Hello, world.~%"))

;; Annoyingly, Codex doesn't do a great job at generating Common Lisp
;; I have to concentrate on languages which work well with Codex.
;; Though, perhaps this is an opportunity to build ilambda for Common Lisp.

(main)