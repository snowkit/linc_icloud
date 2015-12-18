#include "./linc_icloud.h"

#import "hxcpp.h"
#import <Foundation/Foundation.h>

namespace linc {

    namespace icloud {

        namespace keyvalue {

            static InternalStoreChangedExternallyFN callback = 0;

            static void store_changed_externally(NSNotification *notification) {
                NSLog(@"Store Changed!");
                if(callback != null()) {
                    callback();
                }
            }

            NSString* to_NSString(::String str) {
                return @(str.c_str());
            }

            ::String from_NSString(NSString* str) {
                if(str == nil) return null();
                const char* val = [str UTF8String];
                return ::String(val);
            }

            bool internal_init(InternalStoreChangedExternallyFN fn) {
                
                callback = fn;

                [[NSNotificationCenter defaultCenter] 
                     addObserverForName: NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                 object: [NSUbiquitousKeyValueStore defaultStore]
                                  queue: [NSOperationQueue mainQueue]
                             usingBlock: ^(NSNotification *notification) {
                                store_changed_externally(notification);
                            }
                ];

                // get changes that might have happened while this
                // instance of your app wasn't running
                return [[NSUbiquitousKeyValueStore defaultStore] synchronize];

            } //internal_init

            void removeObjectForKey(::String key) {

                [[NSUbiquitousKeyValueStore defaultStore] removeObjectForKey: to_NSString(key)];

            }

            bool synchronize() {

                return [[NSUbiquitousKeyValueStore defaultStore] synchronize];

            }

            void setBoolForKey(::String key, bool val) {

                [[NSUbiquitousKeyValueStore defaultStore] setBool:val forKey: to_NSString(key)];

            }

            bool boolForKey(::String key) {

                return [[NSUbiquitousKeyValueStore defaultStore] boolForKey: to_NSString(key)];

            }
            
            void setIntForKey(::String key, int val) {

                [[NSUbiquitousKeyValueStore defaultStore] setDouble:(double)val forKey: to_NSString(key)];

            }
            
            int intForKey(::String key) {

                return (int)([[NSUbiquitousKeyValueStore defaultStore] doubleForKey: to_NSString(key)]);

            }

            void setFloatForKey(::String key, ::Float val) {

                [[NSUbiquitousKeyValueStore defaultStore] setDouble:(double)val forKey: to_NSString(key)];

            }

            ::Float floatForKey(::String key) {

                return (Float)([[NSUbiquitousKeyValueStore defaultStore] doubleForKey: to_NSString(key)]);

            }

            void setStringForKey(::String key, ::String val) {

                [[NSUbiquitousKeyValueStore defaultStore] setString:to_NSString(val) forKey: to_NSString(key)];

            }
            
            ::String stringForKey(::String key) {

                return from_NSString([[NSUbiquitousKeyValueStore defaultStore] stringForKey: to_NSString(key)]);

            }

        } //keyvalue namespace

    } //icloud namespace

} //linc