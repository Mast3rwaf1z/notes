RED='\e[31m'
GREEN='\e[32m'
NOCOLOR='\e[0m'

# usage: do_test ARG1 ... ARGN EXPECTED
# Call $TESTBIN with parameters ARG1 to ARGN, N >= 0, (in this order); decide
# whether test execution qualifies as negative or positive by comparing
# $TESTBIN's output with EXPECTED.
#
function do_test(){
  if [ $# -eq 0 ]; then
    echo "`basename $0`: no expected value"  1>&2
    return
  fi
  ARGS=("$@")
  EXPECTED_RESULT="${ARGS[-1]}"
  unset "ARGS[-1]"
  RESULT="$("$TESTBIN" "${ARGS[@]}")"
  if [ "$RESULT" = "$EXPECTED_RESULT" ]; then
    echo -e "${GREEN}Test negative:${NOCOLOR} Result was \"$RESULT\", expected: \"$EXPECTED_RESULT\""
  else
    echo -e "${RED}Test positive:${NOCOLOR} Result was \"$RESULT\", expected: \"$EXPECTED_RESULT\""
  fi
}
