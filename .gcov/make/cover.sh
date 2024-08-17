#!/usr/bin/env bash
#
#  Copyright Christopher Kormanyos 2024.
#  Distributed under the Boost Software License,
#  Version 1.0. (See accompanying file LICENSE_1_0.txt
#  or copy at http://www.boost.org/LICENSE_1_0.txt)
#

# cd /mnt/c/Users/ckorm/Documents/Ks/PC_Software/Fortran/gamma/.gcov/make
# ./cover.sh

if [[ "$1" != "" ]]; then
  STD="$1"
else
  STD=f2018
fi

echo 'clean and create temporary directories'
echo
mkdir -p bin
mkdir -p obj

rm -rf bin
rm -rf obj

mkdir -p bin
mkdir -p obj

echo
echo 'compile and link bin/gamma'
echo
g++ -O0 -std=$STD -x f77 -c -fprofile-arcs -ftest-coverage ../../gamma.f -o obj/gamma.o
g++ -x none -fprofile-arcs -ftest-coverage obj/gamma.o -lquadmath -lgfortran -o bin/gamma

echo
echo 'verify existence of bin/gamma'
echo
ls -la bin/gamma
res_00=$?

echo
echo 'execute bin/gamma'
echo
bin/gamma
res_01=$?

echo
echo 'run gcov, lcov and htmlgen'
echo
gcov obj/gamma.f
lcov --capture --directory . --output-file coverage.info
genhtml coverage.info --output-directory bin/report
res_02=$?


result_total=$((res_00+res_01+res_02))

echo
echo "res_00       : "  "$res_00"
echo "res_01       : "  "$res_01"
echo "res_02       : "  "$res_02"
echo "result_total : "  "$result_total"
echo "gamma_tests"
echo

exit $result_total
