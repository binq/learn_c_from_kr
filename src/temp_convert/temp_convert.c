#include <stdio.h>

main() {
	int start_num = 0;
	int end_num = 300;
	int step = 20;
	int source_temp;
	float converted_temp;

	printf("Fahrenheit => Celsius\n", source_temp, converted_temp);
	for(source_temp=start_num; source_temp <= end_num; source_temp += step) {
		converted_temp = (5.0/9.0)*(source_temp-32.0);
		printf("%10u => %7.2f\n", source_temp, converted_temp);
	}
}