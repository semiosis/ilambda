for d in $HOME $MYGIT/semiosis/ilambda/hs/src; do
(
cd "$d"
stack install test-framework
stack install test-framework-hunit
stack install test-framework-quickcheck2
)
done