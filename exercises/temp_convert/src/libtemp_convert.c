#include <stdio.h>
float temp_convert(float temp) {
  return (5.0/9.0)*(temp-32.0);
}
void temp_convert_range(float start_temp, float end_temp, float step) {
  float next_temp = start_temp + step;
  printf("%12.2f => %12.2f\n", start_temp, temp_convert(start_temp));
  if (next_temp <= end_temp) {
    temp_convert_range(next_temp, end_temp, step);
  }
}
void temp_convert_table(float start_temp, float end_temp, float step) {
  printf("%12s => %12s\n", "Fahrenheit", "Celsius");
  temp_convert_range(start_temp, end_temp, step);
}
void temp_convert_range_rev(float start_temp, float end_temp, float step) {
  float next_temp = start_temp - step;
  printf("%12.2f => %12.2f\n", start_temp, temp_convert(start_temp));
  if (next_temp >= end_temp) {
    temp_convert_range_rev(next_temp, end_temp, step);
  }
}
void temp_convert_table_rev(float start_temp, float end_temp, float step) {
  printf("%12s => %12s\n", "Fahrenheit", "Celsius");
  temp_convert_range_rev(start_temp, end_temp, step);
}
