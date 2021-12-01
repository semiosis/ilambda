default: repl

init-repo:
	lein new library ilambda

install:
  lein deps
  lein test
  lein install

repl:
  x -sh 'lein repl' -e '=>' -s '(in-ns '\''main)' -c m -i