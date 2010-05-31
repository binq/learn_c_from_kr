#include <stdio.h>

main() {
	float start_num = 0;
	float end_num = 300;
	float step = 20;
	float source_temp, converted_temp;

	for(source_temp=start_num; source_temp <= end_num; source_temp += step) {
		converted_temp = (5.0/9.0)*(source_temp-32.0);
		printf("%7.2f Fahrenheit => %7.2f Celsius\n", source_temp, converted_temp);
	}
}