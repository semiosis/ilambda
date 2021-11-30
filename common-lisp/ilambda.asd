(defsystem "ilambda"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "ilambda/tests"))))

(defsystem "ilambda/tests"
  :author ""
  :license ""
  :depends-on ("ilambda"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for ilambda"
  :perform (test-op (op c) (symbol-call :rove :run c)))
