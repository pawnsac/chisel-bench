#! /bin/sh

# Deleting a large last member was destroying earlier members.

# This file is part of GNU tar testsuite.
# Copyright (C) 2004 Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

. ./preset
. $srcdir/before

set -e
genfile -l      3 >file1
genfile -l      5 >file2
genfile -l      3 >file3
genfile -l      6 >file4
genfile -l     24 >file5
genfile -l     13 >file6
genfile -l   1385 >file7
genfile -l     30 >file8
genfile -l     10 >file9
genfile -l 256000 >file10
tar cf archive file1 file2 file3 file4 file5 file6 file7 file8 file9 file10
tar f archive --delete file10
tar tf archive

out="\
file1
file2
file3
file4
file5
file6
file7
file8
file9
"

. $srcdir/after
