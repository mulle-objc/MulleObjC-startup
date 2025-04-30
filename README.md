# MulleObjC-startup

#### ▶️  Startup code for MulleObjC

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



| Release Version                                       | Release Notes  | AI Documentation
|-------------------------------------------------------|----------------|---------------
| ![Mulle kybernetiK tag](https://img.shields.io/github/tag/mulle-objc/MulleObjC-startup.svg) [![Build Status](https://github.com/mulle-objc/MulleObjC-startup/workflows/CI/badge.svg)](//github.com/mulle-objc/MulleObjC-startup/actions) | [RELEASENOTES](RELEASENOTES.md) | [DeepWiki for MulleObjC-startup](https://deepwiki.com/mulle-objc/MulleObjC-startup)






### You are here

![Overview](overview.dot.svg)



## Requirements

|   Requirement         | Release Version  | Description
|-----------------------|------------------|---------------
| [# MulleObjC muss no-bequeath sein, wegen dies und das](MulleObjC muss no-bequeath sein, wegen dies und das) | - | ▶️  Startup code for MulleObjC
| [MulleObjC](https://github.com/mulle-objc/MulleObjC) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag/mulle-objc/MulleObjC.svg) [![Build Status](https://github.com/mulle-objc/MulleObjC/workflows/CI/badge.svg?branch=release)](https://github.com/mulle-objc/MulleObjC/actions/workflows/mulle-sde-ci.yml) | 💎 A collection of Objective-C root classes for mulle-objc
| [mulle-atinit](https://github.com/mulle-core/mulle-atinit) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag/mulle-core/mulle-atinit.svg) [![Build Status](https://github.com/mulle-core/mulle-atinit/workflows/CI/badge.svg?branch=release)](https://github.com/mulle-core/mulle-atinit/actions/workflows/mulle-sde-ci.yml) | 🤱🏼 Compatibility library for deterministic initializers
| [mulle-atexit](https://github.com/mulle-core/mulle-atexit) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag/mulle-core/mulle-atexit.svg) [![Build Status](https://github.com/mulle-core/mulle-atexit/workflows/CI/badge.svg?branch=release)](https://github.com/mulle-core/mulle-atexit/actions/workflows/mulle-sde-ci.yml) | 👼 Compatibility library to fix atexit


## Add

Use [mulle-sde](//github.com/mulle-sde) to add MulleObjC-startup to your project.
As long as your sources are using `#import "import-private.h"` and your headers use `#import "import.h"`, there will nothing more to do:

``` sh
mulle-sde add github:mulle-objc/MulleObjC-startup
```

To only add the sources of MulleObjC-startup with all the sources of its
dependencies replace "github:" with [clib:](https://github.com/clibs/clib):

## Legacy adds

One common denominator is that you will likely have to add
`#import <MulleObjC-startup/MulleObjC-startup.h>` to your source files.


### Add sources to your project with clib

``` sh
clib install --out src/mulle-objc mulle-objc/MulleObjC-startup
```

Add `-isystem src/mulle-objc` to your `CFLAGS` and compile all the
sources that were downloaded with your project. (In **cmake** add
`include_directories( BEFORE SYSTEM src/mulle-objc)` to your `CMakeLists.txt`
file).







### Add as subproject with cmake and git

``` bash
git submodule add -f --name "mulle-atinit" \
                            "https://github.com/mulle-core/mulle-atinit.git" \
                            "stash/mulle-atinit"
git submodule add -f --name "mulle-atexit" \
                            "https://github.com/mulle-core/mulle-atexit.git" \
                            "stash/mulle-atexit"
git submodule add -f --name "MulleObjC-startup" \
                            "https://github.com/mulle-objc/MulleObjC-startup" \
                            "stash/MulleObjC-startup"
git submodule update --init --recursive
```

``` cmake
add_subdirectory( stash/MulleObjC-startup)
add_subdirectory( stash/mulle-atexit)
add_subdirectory( stash/mulle-atinit)

target_link_libraries( ${PROJECT_NAME} PUBLIC MulleObjC-startup)
target_link_libraries( ${PROJECT_NAME} PUBLIC mulle-atexit)
target_link_libraries( ${PROJECT_NAME} PUBLIC mulle-atinit)
```


## Install

Use [mulle-sde](//github.com/mulle-sde) to build and install MulleObjC-startup and all dependencies:

``` sh
mulle-sde install --prefix /usr/local \
   https://github.com/mulle-objc/MulleObjC-startup/archive/latest.tar.gz
```

### Legacy Installation


#### Requirements

Install all requirements

| Requirements                                 | Description
|----------------------------------------------|-----------------------
| [# MulleObjC muss no-bequeath sein, wegen dies und das](MulleObjC muss no-bequeath sein, wegen dies und das)             | ▶️  Startup code for MulleObjC
| [MulleObjC](https://github.com/mulle-objc/MulleObjC)             | 💎 A collection of Objective-C root classes for mulle-objc
| [mulle-atinit](https://github.com/mulle-core/mulle-atinit)             | 🤱🏼 Compatibility library for deterministic initializers
| [mulle-atexit](https://github.com/mulle-core/mulle-atexit)             | 👼 Compatibility library to fix atexit

#### Download & Install


Download the latest [tar](https://github.com/mulle-objc/MulleObjC-startup/archive/refs/tags/latest.tar.gz) or [zip](https://github.com/mulle-objc/MulleObjC-startup/archive/refs/tags/latest.zip) archive and unpack it.

Install **MulleObjC-startup** into `/usr/local` with [cmake](https://cmake.org):

``` sh
PREFIX_DIR="/usr/local"
cmake -B build                               \
      -DMULLE_SDK_PATH="${PREFIX_DIR}"       \
      -DCMAKE_INSTALL_PREFIX="${PREFIX_DIR}" \
      -DCMAKE_PREFIX_PATH="${PREFIX_DIR}"    \
      -DCMAKE_BUILD_TYPE=Release &&
cmake --build build --config Release &&
cmake --install build --config Release
```


## Author

[Nat!](https://mulle-kybernetik.com/weblog) for Mulle kybernetiK  



