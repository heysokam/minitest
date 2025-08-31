//:____________________________________________________________
//  minitest  |  Copyright (C) Ivan Mar (sOkam!)  |  MPL-2.0  :
//:____________________________________________________________
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

