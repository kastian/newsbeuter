#!/bin/sh

APPBASE_INFO=appbase.info
APPTEST_INFO=apptest.info
APPTOTAL_INFO=apptotal.info

make distclean
rm -rf $APPBASE_INFO $APPTEST_INFO html
make -j 5 PROFILE=1 all test-rss
lcov -c -i -b . -d . -o $APPBASE_INFO --compat split_crc=on
export OFFLINE=1
( cd test && ./test-rss )
lcov -c -b . -d . -o $APPTEST_INFO --compat split_crc=on
lcov -b . -d . -a $APPBASE_INFO -a $APPTEST_INFO -o $APPTOTAL_INFO
lcov --remove $APPTOTAL_INFO 'test/*' '/usr/*' --output-file $APPTOTAL_INFO
