# Compatible with GNU make and BSD make.

include config.mk

install:
	@echo Installing to to ${PREFIX}/bin ...
	@mkdir -p ${PREFIX}/bin
	@cp -f viconf.sh ${PREFIX}/bin/viconf
	@cp -f viconf-check.sh ${PREFIX}/bin/viconf-check
	@cp -f viconf-commit.sh ${PREFIX}/bin/viconf-commit
	@cp -f viconf-syncdb.sh ${PREFIX}/bin/viconf-syncdb
	@chmod 755 ${PREFIX}/bin/viconf
	@chmod 755 ${PREFIX}/bin/viconf-check
	@chmod 755 ${PREFIX}/bin/viconf-commit
	@chmod 755 ${PREFIX}/bin/viconf-syncdb
	@viconf-syncdb

uninstall:
	@echo Uninstalling from ${PREFIX}/bin ...
	@rm -f ${PREFIX}/bin/viconf
	@rm -f ${PREFIX}/bin/viconf-check
	@rm -f ${PREFIX}/bin/viconf-commit
	@rm -f ${PREFIX}/bin/viconf-syncdb
