
#pragma once
#ifndef FOO_PRIVATE_HEADER_H
#define FOO_PRIVATE_HEADER_H

#include <string>

class FooHelper
{
 public:
	FooHelper() {}

	std::string help() const {
		return "I'm just here to help Foo";
	}

 private:
};

#endif // ifndef FOO_PRIVATE_HEADER_H
