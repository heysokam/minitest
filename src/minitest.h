//:____________________________________________________________
//  minitest  |  Copyright (C) Ivan Mar (sOkam!)  |  MPL-2.0  :
//:____________________________________________________________
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>


#if defined __unix
#define color_R     "\x1b[31m"
#define color_G     "\x1b[32m"
#define color_B     "\x1b[34m"
#define color_C     "\x1b[36m"
#define color_M     "\x1b[35m"
#define color_Y     "\x1b[33m"
#define color_Reset "\x1b[0m"
#else
#define color_R
#define color_G
#define color_B
#define color_C
#define color_M
#define color_Y
#define color_Reset
#endif  // unix

#define pfx_Pass " ✓ "
#define pfx_Skip "   "
#define pfx_Todo " ? "
#define pfx_Fail "[𐄂]"
#define pfx_Name "[߹]" color_C " minitest:"


// clang-format off
#define check(condition, msg)                                \
  do {                                                       \
    if (!condition) {                                        \
      printf(                                                \
        color_R pfx_Fail color_Y " %s" color_Reset ": %s\n"  \
        "    Failed check at     : %s:%d\n"                  \
        "    Condition was false : `%s`\n",                  \
        __func__, msg,                                       \
        __FILE__, __LINE__,                                  \
        #condition                                           \
      );                                                     \
      return 1;                                              \
    }                                                        \
  } while (0);
// clang-format on


#define it(title, name, body)                            \
  static bool name() {                                   \
    do body while (0);                                   \
    printf(color_G pfx_Pass color_Reset " %s\n", title); \
    return 0;                                            \
  }


#define describe(title, body)                                    \
  int main() {                                                   \
    printf(color_C pfx_Name color_M " %s\n" color_Reset, title); \
    do body while (0);                                           \
    return 0;                                                    \
  }

