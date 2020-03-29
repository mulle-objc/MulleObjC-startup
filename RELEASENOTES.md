## 0.17.0

* Various small improvements


## 0.16.0

* readonly properties aren't cleared anymore for compatibility
* remove mistakenly added craftinfo
* rename MulleObjCGetClass to MulleObjCObjectGetClass and SetClass too
* remove PROTOCOLCLASS warnings with `_Pragma`
* added MulleObjCClassGetLoadAddress
* modernized to new mulle-test
* modernized mulle-sde with .mulle folder
* adapt to changes in 0.14.0
* reworked the universe configuration to make it easier to understand
* moved some of the convenience debug code from mulle-objc-runtime to MulleObjC
* MulleObjC is now universe aware
* restructured project and implemented a lot of the new naming scheme
* update sde, fix for mingw
* use modernized mulle-sde-developer include/import scheme
* moved compiler and runtime tests to mulle-objc-runtime
* migrated to mulle-sde
* `_MulleObjCObjectReleaseProperties` is now `_MulleObjCInstanceClearProperties` because we also clean C pointers
* ... `infinite_retain` became infiniteretain
* Separate startup from standalone
* add MulleObjCGetObjectIvar and friends
* follow mulle-configuration 3.1 changes and move .travis.yml to trusty
* fixes for mingw
* some changes to compile with mingw
* fix newly introduced problems
* modernize CMakeDependencies.txt and CMakeLists.txt
* improved universe tear down code to be shared with standard foundation
* added a test for +initialize
