#pragma once

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

namespace linc {

    namespace icloud {

        namespace keyvalue {
            
            #if (HXCPP_API_LEVEL>=330)
                typedef void LinciCloudVoid;
            #else
                typedef Void LinciCloudVoid;
            #endif

            typedef ::cpp::Function < LinciCloudVoid(int,::Array< ::String >) > InternalStoreChangedExternallyFN;
            extern bool internal_init(InternalStoreChangedExternallyFN fn);

            extern void removeObjectForKey(::String key);
            extern bool synchronize();

            extern void setBoolForKey(::String key, bool val);
            extern bool boolForKey(::String key);

            extern void setIntForKey(::String key, int val);
            extern int intForKey(::String key);

            extern void setFloatForKey(::String key, ::Float val);
            extern ::Float floatForKey(::String key);

            extern void setStringForKey(::String key, ::String val);
            extern ::String stringForKey(::String key);

        } //keyvalue

    } //icloud namespace

} //linc
