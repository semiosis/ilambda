default: hs

hs: clean-hs
	cd hs && cabal build

clean-hs:
	# cd into hs and clean cabal
	cd hs && cabal clean

clean:
	rm -rf hs/dist-newstyle