#include <libtemp_convert.h>
#define START_TEMP -459.67
#define END_TEMP 10000.0
#define STEP 20.0
main() {
  temp_convert_table(START_TEMP, END_TEMP, STEP);
  return 0;
}
