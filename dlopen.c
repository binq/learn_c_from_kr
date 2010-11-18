#include <stdio.h>
#include <dlfcn.h>

int main() {
	void *handle;
	float (*convert) (float);
	handle = dlopen("./libtemp_convert.dylib", RTLD_LAZY);
	if(!handle) {
		fputs(dlerror(), stderr);
		printf("\nwe suck\n");
		return 1;
	}

	float f;
	float c;

	convert = dlsym(handle, "temp_convert");

	printf("We have %f", (*convert)(30.0));
	dlclose(handle);

}
