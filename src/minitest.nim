#:_______________________________________________________________________
#  minitest  |  Copyright (C) Ivan Mar (sOkam!)  |  GNU GPLv3 or later  :
#:_______________________________________________________________________
# @deps std
import std/unittest ; export unittest
unittest.abortOnError = true
template describe *(name :string; body :untyped) :untyped= unittest.suite(name, body)
template it       *(name :string; body :untyped) :untyped= unittest.test(name, body)
template expect   *(cond :untyped) :untyped= unittest.check(cond)
# TODO: Remove the std/unittest dependency

