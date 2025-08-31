# minitest | Minimalist Unit Testing Library
Tiny Single-file helper tools for writing Unit Tests.  
Supports C, C++ and Zig.  

## Minimalism
`minitest` aims to be as minimal as possible, while still providing helpful tools.  
Just one small step away from "I can write that in 1h".  

## Examples
Please check out the @[examples](./examples/) folder for samples of how to use the library.  
The API is extremely minimal.  
You can learn how to use it just by reading the examples.  


## Overview: C API
```c
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
```
The C API is **just 3 macros**:  
- `describe`: Creates a main function were you can run your test cases  
- `it`: Describes a single unit test function where you can run your checks  
- `check`: Test a condition, with a feedback message  

That's it. No bloat.  


## Overview: C++ API
```cpp
#include <minitest.hpp>

int main(void) {
  it("must do simple thing for C++", []() {
    expect(true).toBe(true);
  });

  it("must fail simple thing for C++", []() {
    expect(true).toBe(false);
  });
}
```


## Overview: Zig API
```zig
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

}
```
Reasons for the Zig API to exist:
- I found the Zig `test` api to be too silent.  
  _Passing tests are just ignored from CLI reports._  
- The `test` api does not allow for creation of arbitrary groupings of _individual/separate_ tests _(ie: describe)_.  
  _You are expected to either add all tests into one big massive test (ie: treat `test` as `describe`),_  
  _or treat `test` as `it` and not have `describe` at all._  
  _I wanted both._  
- I wanted a minimal syntax for declaring what the tests will do.  
- I found the `(expected,result)` arguments inversion of the `std.testing.***` API to be extremely confusing and time-wasting.  


## License & Usage
This project is covered under the [Mozilla Public License 2.0](https://www.mozilla.org/en-US/MPL/2.0/FAQ/).

The [MPL v2.0](https://www.mozilla.org/en-US/MPL/2.0/FAQ/) is a per-file weak copyleft license.  

Just like with MIT, you _can_ use this project in a closed source application,  
without the license spreading to your own files, or having to build the code into a dynamic library.  
_(ie: like GPL/LGPL would require)_  
If you don't modify anything, you can use _(and relicense)_ the code into your app as if it was MIT/BSD.  

The MPL is a not-so-well-known license.  
Please read their [FAQ](https://www.mozilla.org/en-US/MPL/2.0/FAQ/) if you were not aware of its existence.  

