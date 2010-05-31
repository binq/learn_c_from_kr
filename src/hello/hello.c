#include <string.h>
#include <stdio.h>

main(int argc, char **argv) {
	char *name = argc > 1 ? argv[1] : "World";
	printf("Hello %s\n", name);
}
