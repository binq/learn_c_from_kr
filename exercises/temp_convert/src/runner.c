#include <stdio.h>
#include "/Users/vanson/Projects/learn_c_from_kr/exercises/temp_convert/include/temp_convert.h"
#define START_TEMP -459.67
#define END_TEMP 10000
#define STEP 20

void temp_convert_range(float temp) {
	float next_temp = temp + STEP;

	printf("%12.2f => %12.2f\n", temp, temp_convert(temp));
	if (next_temp <= END_TEMP) temp_convert_range(next_temp);
}

main() {
	printf("%12s => %12s\n", "Fahrenheit", "Celsius");
	temp_convert_range(START_TEMP);
	
	return 0;
}