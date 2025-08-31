//:____________________________________________________________
//  minitest  |  Copyright (C) Ivan Mar (sOkam!)  |  MPL-2.0  :
//:____________________________________________________________
const minitest = @import("minitest");
const it = minitest.it;

var  HowTo = minitest.title("title | Test Cases");
test HowTo { HowTo.begin(); defer HowTo.end();

try it("must do simple thing for Zig", struct { fn f() !void {
  return;
}}.f);

it("must fail simple thing for Zig", struct { fn f() !void {
  return error.HelloIt;
}}.f);

} //:: minitest.BaseCases

