//:____________________________________________________________
//  minitest  |  Copyright (C) Ivan Mar (sOkam!)  |  MPL-2.0  :
//:____________________________________________________________
#ifndef H_minitest
#define H_minitest
// @deps stdlib
#include <cassert>
#include <cstdlib>
#include <iostream>
#include <ostream>
#include <stdexcept>
#include <string>
#include <string_view>
#include <format>

#define pure __attribute__((const))

namespace unittest {

inline void it(std::string_view name, std::invocable<> auto&& fn) {
  try {
    fn();
    std::cout << "✓ " << name << std::endl;
  } catch (std::runtime_error const& err) {
    std::cerr << "❌ " << name << std::endl;
    std::cerr << "  Error: " << err.what() << std::endl;
    std::exit(101);
  }
}

template <typename T>
class Expect {
 public:
  T m_result;

  inline bool toBe(T expected) {
    std::string msg = std::format("result ({}) should be equal to expected ({})", m_result, expected);
    bool condition = m_result == expected;
    if (!condition) throw std::runtime_error(msg);
    return condition;
  }  //:: Expect.toBe
};  //:: Expect

template <typename T>
inline pure Expect<T> expect(T result) {
  auto E = Expect<T>();
  E.m_result = result;
  return E;
}  //:: expect

};  // namespace unittest
#endif  // H_minitest

