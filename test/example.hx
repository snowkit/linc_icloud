

//These aren't called, but are useful
    // icloud.KeyValue.synchronize              https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSUbiquitousKeyValueStore_class/#//apple_ref/occ/instm/NSUbiquitousKeyValueStore/synchronize
    // icloud.KeyValue.removeObjectForKey       https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSUbiquitousKeyValueStore_class/#//apple_ref/occ/instm/NSUbiquitousKeyValueStore/removeObjectForKey:

//This isn't there yet, but I'll add it:
    // dictionaryRepresentation                 https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSUbiquitousKeyValueStore_class/#//apple_ref/occ/instp/NSUbiquitousKeyValueStore/dictionaryRepresentation


//This should happen as early as possible in your app

    trace('');
    trace('iCloud / init');

    var res = icloud.KeyValue.init(function(info:icloud.KeyValue.KeyValueStoreDidChangeNotification) {
        trace('Something changed?!');
        trace('Reason? ' + info.changeReason);
        trace('Keys? ' + info.changedKeys);
    });

    trace('iCloud / init result / $res');


//These happen anywhere

    trace('');
    trace('iCloud / old values:');
    trace('iCloud / old int / ${icloud.KeyValue.intForKey('int')}');
    trace('iCloud / old bool / ${icloud.KeyValue.boolForKey('bool')}');
    trace('iCloud / old string / ${icloud.KeyValue.stringForKey('string')}');
    trace('iCloud / old float / ${icloud.KeyValue.floatForKey('float')}');

    var int = Std.random(10);
    var bool = int > 5;
    var float = Math.random() * 100;
    var string = 'string(int=$int)(float=$float)';

    trace('');
    trace('iCloud / setting new values:');
    trace('iCloud / new int / $int');
    trace('iCloud / new bool / $bool');
    trace('iCloud / new string / $string');
    trace('iCloud / new float / $float');

    icloud.KeyValue.setIntForKey('int',int);
    icloud.KeyValue.setBoolForKey('bool', bool);
    icloud.KeyValue.setStringForKey('string', string);
    icloud.KeyValue.setFloatForKey('float', float);

    trace('');
    trace('iCloud / done');
