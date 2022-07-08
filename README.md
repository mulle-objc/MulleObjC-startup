# MulleObjC-startup

#### ▶️  Startup library for MulleObjC

This static library provides the required `__register_mulle_objc_universe`
function for executables, that link against
[MulleObjC](//github.com/mulle-objc/MulleObjC).
It also bequeaths the required dependencies
[mulle-atinit](//github.com/mulle-core/mulle-atinit) and
[mulle-atexit](//github.com/mulle-core/mulle-atexit) for linking.

Use this library, if you want to create executables, that only
require the [MulleObjC](//github.com/mulle-objc/MulleObjC)
and nothing else. Often projects will link against the
[Foundation](//github.com/MulleFoundation/Foundation) though, and will use
its startup library.


Build Status | Release Version
-------------|-----------------------------------
[![Build Status](//travis-ci.org/mulle-objc/MulleObjC-startup.svg)](//travis-ci.org/mulle-objc/mulle-objc) | ![Mulle kybernetiK tag](//img.shields.io/github/tag/mulle-objc/MulleObjC-startup.svg) [![Build Status](//travis-ci.org/mulle-objc/MulleObjC-startup.svg?branch=release)](//travis-ci.org/mulle-objc/MulleObjC-startup)


## Add 

Use [mulle-sde](//github.com/mulle-sde) to add MulleObjC-startup to your project:

```
mulle-sde dependency add --objc \
                         --github mulle-objc \
                         --marks no-intermediate-link,no-dynamic-link 
                         MulleObjC-startup
```

## Install

See [mulle-objc-developer](//github.com/mulle-objc/mulle-objc-developer) for the preferred
way to install MulleObjC-startup


### Platforms and Compilers

All platforms and compilers supported by
[mulle-c11](//github.com/mulle-c/mulle-c11/) and
[mulle-thread](//github.com/mulle-concurrent/mulle-thread/).


## Author

[Nat!](//www.mulle-kybernetik.com/weblog) for
[Mulle kybernetiK](//www.mulle-kybernetik.com) and
[Codeon GmbH](//www.codeon.de)
