# linc/iCloud
Haxe/hxcpp @:native bindings for [iCloud](https://developer.apple.com/icloud/).

This library was graciously sponsored by http://grapefrukt.com/ for http://twofoldinc.com/

This is a [linc](http://snowkit.github.io/linc/) library.

---

This library works with the Haxe cpp target only.

---
### Install

`haxelib git linc_icloud https://github.com/snowkit/linc_icloud.git`

### Important notes

Linking to the iCloud framework does require the framework to exist. If you target lower version devices that don't have iCloud support for the features, you have to Weak Link the reference in your Xcode project to avoid crashes on start up.

Read this [Apple documentation on frameworks](https://developer.apple.com/library/mac/documentation/MacOSX/Conceptual/BPFrameworks/Concepts/WeakLinking.html#//apple_ref/doc/uid/20002378-BBCJICEC) under “Weak Linking to Entire Frameworks”

You may need to remove the link Xcode/iCloud toggle adds for you, and readd it as a weak link or change the type.

### Endpoints

Currently, the following iCloud API's are bound and available:

- Key-Value storage (import icloud.KeyValue)

### Example usage

See test/example.hx for now
