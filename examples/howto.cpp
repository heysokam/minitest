#include <minitest.hpp>

int main(void) {
  it("must do simple thing for C++", []() {
    expect(true).toBe(true);
  });

  it("must fail simple thing for C++", []() {
    expect(true).toBe(false);
  });
}

