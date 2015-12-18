#ifndef _LINC_ICLOUD_H_
#define _LINC_ICLOUD_H_
    
#include <hxcpp.h>

namespace linc {

    namespace icloud {

        namespace keyvalue {

            typedef ::cpp::Function < Void(int,::Array< ::String >) > InternalStoreChangedExternallyFN;
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

#endif //_LINC_ICLOUD_H_
