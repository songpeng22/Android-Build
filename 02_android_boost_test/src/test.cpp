#include "test.h"

#include <stdio.h>

#include <iostream>
#include <iterator>
//boost.lamda
#include <algorithm>
#include <boost/lambda/lambda.hpp>
//boost.system
#include <boost/system/error_code.hpp>
using namespace boost::system;

void fail(error_code &ec)
{
    ec = errc::make_error_code(errc::not_supported);
}

int main()
{
    printf("hello cmake android.\n");
    //boost
#if 1
    error_code ec;
    fail(ec);
    std::cout << ec.value() << '\n';
#else
    std::vector<int> v{1, 3, 2};
    std::for_each(v.begin(), v.end(),
    std::cout << boost::lambda::_1 << "\n");
#endif
    return 0;
}
