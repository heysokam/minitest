//:_____________________________________________________________________
//  minitest  |  Copyright (C) Ivan Mar (sOkam!)  |  GNU LGPLv3 or later  :
//:_____________________________________________________________________
// @deps minitest
const minitest = @import("./minitest.zig");
const it = minitest.it;

//______________________________________
// @section Validate Usage
//____________________________
var  BaseCases = minitest.title("minitest | Base Functionality");
test BaseCases { BaseCases.begin(); defer BaseCases.end();

try minitest.err(error.HelloIt,
  it("should run with an error", struct { fn f() !void {
    return error.HelloIt;
  }}.f)
);

try it("should run without an error", struct { fn f() !void {
  return;
}}.f);

} //:: minitest.BaseCases

