divert(-1)dnl
#------------------------------------------------------------------------------
# macros for lists in m4
#------------------------------------------------------------------------------
# Copyright (c) 2001, 2020, 2023, Andreas F. Borchert
# All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
# KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#------------------------------------------------------------------------------
changequote({,})
define(P1, {changequote([,])`}$[]1{'changequote`'})
define(P2, {changequote([,])`}$[]2{'changequote`'})
define(P3, {changequote([,])`}$[]3{'changequote`'})
define(PP1, {changequote([,])``}$[]1{''changequote`'})
define(PP2, {changequote([,])``}$[]2{''changequote`'})
define(PP3, {changequote([,])``}$[]3{''changequote`'})
changequote
#------------------------------------------------------------------------------
# def_list(NAME)
# defines
#    NAME_add      allows to add items to the list
#    NAME_len      return current number of items in the list
#    NAME_expand   allows to expand a text for all members of the list
#------------------------------------------------------------------------------
define(`def_list', `dnl
`'define(`$1_index', 0)dnl
`'define(`$1_incr_index', `'`define(`$1_index', incr($1_index))dnl')`'dnl
`'define(`$1_len', `$1_index')dnl
`'define(`$1_add', `define(`$1_val_'$1_index, 'P1`)$1_incr_index()')`'dnl
`'define(`$1_recursive_expand', `ifelse('P1`,$1_len,, `define(''PP2``, $1_val_''P1``)''P3``
$1_recursive_expand(incr(''P1``), ''PP2``, ''PP3``)')')dnl
`'define(`$1_expand', `$1_recursive_expand(0, 'P1`, 'P2`)dnl')`'')
#------------------------------------------------------------------------------
divert`'dnl
