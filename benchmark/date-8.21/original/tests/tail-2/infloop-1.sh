#!/bin/sh
# This test would fail with tail from pre-1.22i textutils.

# Copyright (C) 1999-2013 Free Software Foundation, Inc.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

. "${srcdir=.}/tests/init.sh"; path_prepend_ ./src
print_ver_ tail

yes > t &
yes_pid=$!
while :; do
  test -s t && break
  sleep .1
done
tail -n 1 t &
tail_pid=$!
kill $yes_pid

# This test is racy, and can fail under unusual circumstances.
# On a very busy system, tail will fail to notice that $yes_pid is gone.
# Then the following kill will succeed and cause this test to fail.

# Wait for up to 3 seconds for tail to detect the death of $yes_pid.
for i in $(seq 30); do
    kill -0 $tail_pid || break
    echo sleep 0.1s
    sleep .1
done

kill $tail_pid && fail=1 || :

Exit $fail
