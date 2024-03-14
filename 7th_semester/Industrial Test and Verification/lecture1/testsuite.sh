#!/bin/bash

# This is a test script for the tool-rental use case.
# The script reports whether the result of the test is equal to the given
# expected value.
#
# The program that is executed determines whether a new tool may be borroweded, and
# if so, computes the price including the respective discount.

TESTBIN="./discount_calc"
source ./testsuite_prelude.sh

################################### EXAMPLES ###################################

# owns 38 tools, has 4 tools borrowed, has 0 bad ratings, is a student;
# borrowed for 699 DKK, 8% discount: 643 DKK
do_test 38 4 0 1 699 643

# owns 53 tools, has 5 tools borrowed, has 0 bad ratings, is a student;
# borrowed for 899 DKK, 5% discount: 854 DKK
do_test 53 5 0 1 899 854

# same test as above but with (intentionally) wrong expected value
do_test 53 5 0 1 899 855

#################### INSERT YOUR TEST CASES AFTER THIS LINE ####################
