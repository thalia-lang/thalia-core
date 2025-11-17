#include <thalia-core/system.h>
#include <thalia-core/string.h>

extern int main(void) {
  int32_t code = core__string__size("Hello World!");
  core__system__exit(code);
}

