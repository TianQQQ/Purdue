default:
	cd makeprocs; make
	cd injectionS2; make
	cd injectionCO; make
	cd reaction1; make
	cd reaction2; make
	cd reaction3; make

clean:
	cd makeprocs; make clean
	cd injectionS2; make clean
	cd injectionCO; make clean
	cd reaction1; make clean
	cd reaction2; make clean
	cd reaction3; make clean

run:
	cd ../../bin; dlxsim -x os.dlx.obj -a -u makeprocs.dlx.obj 4 12; ee469_fixterminal
