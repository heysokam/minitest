//:_______________________________________________________________________
//  minitest  |  Copyright (C) Ivan Mar (sOkam!)  |  GNU GPLv3 or later  :
//:_______________________________________________________________________
#include <minitest.h>

it("must do simple thing for C", t001, {
  check(true, "Always pass");
})

it("must fail simple thing for C", t002, {
  check(false, "Always fail");
})

describe("title | Test Cases", {
  t001();
  t002();
})

