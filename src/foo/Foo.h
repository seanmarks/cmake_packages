
#pragma once
#ifndef FOO_H
#define FOO_H

#if xdrfile_ENABLED
#include "xdrfile/xdrfile_xtc.h"
#endif

class Foo
{
 public:
	Foo() {}
	Foo(const int x): x_(x) {}

	int get_x() const {
		return x_;
	}

	int doStuff() const;

 private:
	int x_ = 0;
};

#endif // ifndef FOO_H
