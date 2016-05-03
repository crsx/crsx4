// Copyright (c) 2016 IBM Corporation.
#include <iostream>

#include "term.h"
#include "compat.h"

namespace ts
{
namespace runtime
{

// --- Ref

_Ref::_Ref() :
        refcount(1)
{
}

_Ref::~_Ref()
{
    assert(refcount == 0);
}

void _Ref::Ref()
{
    assert(refcount > 0);
    refcount++;
}

void _Ref::Release()
{
    assert(refcount > 0);
    refcount--;
    if (refcount == 0)
        delete this;
}

// --- String

static StringTerm stringTerm(std::string&& val)
{
    return *(new _ValStringTerm(val));
}


_ValStringTerm::_ValStringTerm(std::string& val) :
        value(val)
{
}

_ValStringTerm::~_ValStringTerm()
{
    // value will be deleted.
}

Term _ValStringTerm::Copy(Context c)
{
    Ref();
    return *this;
}

Optional<std::string> _ValStringTerm::Unbox() const
{
    return make_optional<std::string>(value);
}

} // runtime
} // ts

using namespace ts::runtime;

int main(int argc, char **argv)
{
    std::string s {"Boo"};
    StringTerm v = stringTerm("boo");

    //Optional<StringTerm> o = make_optional<StringTerm>(new _ValStringTerm(new std::string("Boo")));
    std::cout << "boo!" << v.refcount;

    v.Release();
    std::cout << "\nboo!" << v.refcount;

}

