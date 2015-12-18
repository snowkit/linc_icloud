package icloud;

@:keep
@:include('linc_icloud.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('icloud'))
#end
extern class KeyValue {

    static inline function init(func:Void->Void) : Bool return KeyValueInternal.init(func);

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
    private static function internal_init(func:cpp.Callable<Void->Void>) : Bool;

}

@:allow(icloud.KeyValue)
private class KeyValueInternal {

    static var callback : Void->Void;

    static function init(func:Void->Void) : Bool {

        callback = func;

        return KeyValue.internal_init(cpp.Callable.fromStaticFunction(internal_callback));

    }

    static function internal_callback() {

        //:todo: Implement callback types and data transforms on native side
        trace('internal callback!');

    }

}