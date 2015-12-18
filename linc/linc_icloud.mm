#include "./linc_icloud.h"

#import "hxcpp.h"
#import <Foundation/Foundation.h>

namespace linc {

    namespace icloud {

        namespace keyvalue {

            static NSString* to_NSString(::String str) { return @(str.c_str()); }
            static ::String from_NSString(NSString* str) {
                if(str == nil) return null();
                const char* val = [str UTF8String];
                return ::String(val);
            }

            static InternalStoreChangedExternallyFN callback = 0;

            static void store_changed_externally(NSNotification *notification) {

                NSLog(@"Store Changed!");
                if(callback != null()) {

                    int return_reason = -1;

                    NSDictionary* user_info = [notification userInfo];
                    NSNumber *change_reason = [user_info objectForKey:NSUbiquitousKeyValueStoreChangeReasonKey];

                        if(change_reason != nil) {
                                //this may not be necessary, can cast enum to int, but for now its fine
                            NSInteger reason = [change_reason integerValue];
                            switch(reason) {
                                case NSUbiquitousKeyValueStoreServerChange:
                                    return_reason = 0; break;
                                case NSUbiquitousKeyValueStoreInitialSyncChange:
                                    return_reason = 1; break;
                                case NSUbiquitousKeyValueStoreQuotaViolationChange:
                                    return_reason = 2; break;
                                case NSUbiquitousKeyValueStoreAccountChange:
                                    return_reason = 3; break;
                            }
                        }

                    NSArray* changed_keys = [user_info objectForKey:NSUbiquitousKeyValueStoreChangedKeysKey];
                    if(changed_keys == nil) {
                        callback(return_reason, null());
                        return;
                    }

                    int key_count = [changed_keys count];
                    Array< ::String> return_arr = new Array_obj< ::String>(key_count,key_count);
                    for (NSString* key in changed_keys) {
                        return_arr.Add( from_NSString(key) );
                    }

                    callback(return_reason, return_arr);

                } //callback != null()

            } //store_changed_externally

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