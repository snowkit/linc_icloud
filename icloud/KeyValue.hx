package icloud;

@:enum abstract KeyValueStoreChangeReason(Int)
    from Int to Int {

    var ServerChange = 0;
    var InitialSyncChange = 1;
    var QuotaViolationChange = 2;
    var AccountChange  = 3;

    inline function toString() {
        return switch(this) {
            case ServerChange:          return 'ServerChange';
            case InitialSyncChange:     return 'InitialSyncChange';
            case QuotaViolationChange:  return 'QuotaViolationChange';
            case AccountChange:         return 'AccountChange';
            case _:                     return '$this';
        }
    }

} //KeyValueStoreChangeReason

typedef KeyValueStoreDidChangeNotification = {
    var changeReason: Null<KeyValueStoreChangeReason>;
    var changedKeys: Array<String>;
}

@:keep
@:include('linc_icloud.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('icloud'))
#end
extern class KeyValue {

    static inline function init(func:KeyValueStoreDidChangeNotification->Void) : Bool {
        return KeyValueInternal.init(func);
    }

    @:native('linc::icloud::keyvalue::synchronize')
    static function synchronize() : Bool;

    @:native('linc::icloud::keyvalue::removeObjectForKey')
    static function removeObjectForKey(key:String) : Void;

    @:native('linc::icloud::keyvalue::setBoolForKey')
    static function setBoolForKey(key:String, val:Bool) : Void;
    
    @:native('linc::icloud::keyvalue::boolForKey')
    static function boolForKey(key:String) : Bool;
    
    @:native('linc::icloud::keyvalue::setIntForKey')
    static function setIntForKey(key:String, val:Int) : Void;
    
    @:native('linc::icloud::keyvalue::intForKey')
    static function intForKey(key:String) : Int;
    
    @:native('linc::icloud::keyvalue::setFloatForKey')
    static function setFloatForKey(key:String, val:Float) : Void;
    
    @:native('linc::icloud::keyvalue::floatForKey')
    static function floatForKey(key:String) : Float;
    
    @:native('linc::icloud::keyvalue::setStringForKey')
    static function setStringForKey(key:String, val:String) : Void;
    
    @:native('linc::icloud::keyvalue::stringForKey')
    static function stringForKey(key:String) : String;

    @:allow(icloud.KeyValueInternal)
    @:native('linc::icloud::keyvalue::internal_init')
    private static function internal_init(func:cpp.Callable<Int->Array<String>->Void>) : Bool;

}

@:allow(icloud.KeyValue)
private class KeyValueInternal {

    static var callback : KeyValueStoreDidChangeNotification->Void;

    static function init(func:KeyValueStoreDidChangeNotification->Void) : Bool {

        if(func == null) throw "iCloud callback mustn't be null";
        if(callback != null) throw "iCloud callback already set, are you accidentally calling init twice?";

        callback = func;

        return KeyValue.internal_init(cpp.Callable.fromStaticFunction(internal_callback));

    } //

    static function internal_callback(reason:Int, keys:Array<String>) {

        callback({
            changeReason: reason == -1 ? null : reason,
            changedKeys: keys
        });

    } //

}