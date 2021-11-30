(defpackage ilambda/tests/main
  (:use :cl
        :ilambda
        :rove))
(in-package :ilambda/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :ilambda)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
