
#include <iostream>
#include <stdexcept>
#include <string>

#include "foo/Foo.h"

int main(const int argc, const char* argv[])
{
	if ( argc < 2 ) {
		std::cout << "Error: missing user input\n";
		return 1;
	}

	int x = std::stod( argv[1] );
	Foo foo(x);
	std::cout << "x = " << x << " --> foo.doStuff() = " << foo.doStuff() << "\n";

	return 0;
}
