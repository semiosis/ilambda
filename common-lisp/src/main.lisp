(defpackage ilambda
  (:use :cl))
(in-package :ilambda)

(defun main ()
  (my-call-process "tv" nil)
  (format t "Hello, world.~%"))

(main)