stack-cabal-run:
	cd hs-stack && cabal run ilambda-exe

stack-gen-hie:
	cd hs-stack && gen-hie

cabal-run:
	cd hs-cabal && cabal run ilambda-exe

cabal-gen-hie:
	cd hs-cabal && gen-hie