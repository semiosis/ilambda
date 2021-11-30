(defsystem "common-lisp"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "common-lisp/tests"))))

(defsystem "common-lisp/tests"
  :author ""
  :license ""
  :depends-on ("common-lisp"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for common-lisp"
  :perform (test-op (op c) (symbol-call :rove :run c)))
