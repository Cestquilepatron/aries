#!/bin/bash

# Checks that the GG solver can effectively solve all specified problems.
# Problem to be solved should be provided either as a file (first argument) or through
# standard input.
# Input should contain on problem file per line, lines starting with '#' are ignored
#
# Solvers are run in parallel (defaulting to one per core) using GNU parallel.

# example to run it
# find problems/planning -name instance-1.pddl | grep strips | grep 1998 | sort | ./problems/planning/gg-solve-all.sh

# path to GG and timeout can be customized with the GG and TIMEOUT environment vairables

set -e # Exit on first error

# Path TO GG (defaults to debug build)
GG="${GG:-target/release/gg}"

# Time allowed for each run (defaults to 10s)
TIMEOUT="${TIMEOUT:-10s}"

echo "Building..."
cargo build
cargo build --release




# Read problems from first argument or standard input if not provided
[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
cat $input | grep -v '^#' |  parallel -v --halt-on-error now,fail=1 "timeout ${TIMEOUT} ${GG} --expect-sat {}"
