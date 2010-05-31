#include <stdio.h>
#define START_NUM 0
#define END_NUM 300
#define STEP 20

main() {
	int source_temp;
	float converted_temp;

	printf("Fahrenheit => Celsius\n", source_temp, converted_temp);
	for(source_temp=END_NUM; source_temp >= START_NUM; source_temp -= STEP) {
		converted_temp = (5.0/9.0)*(source_temp-32.0);
		printf("%10u => %7.2f\n", source_temp, converted_temp);
	}
}