
#pragma once
#ifndef FOO_H
#define FOO_H

#if xdrfile_ENABLED
#include "xdrfile/xdrfile_xtc.h"
#endif // if xdrfile_ENABLED

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

#if xdrfile_ENABLED
	XDRFILE* xdr_file_handle_;
#endif // if xdrfile_ENABLED
};

#endif // ifndef FOO_H
