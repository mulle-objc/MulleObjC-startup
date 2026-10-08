## 0.23.0




feature: make MulleObjC-startup consumable via `add_subdirectory` and `find_package`

* force-link the library into consumers so its atinit/atexit constructors run even when no symbol is referenced
* `add_subdirectory` consumers now automatically inherit the include directory and transitive link dependencies
* `find_package` consumers resolve dependencies by name instead of build-time absolute paths
* simplified subproject integration: a single submodule plus ``add_subdirectory(stash/)`` is now sufficient


## 0.22.0


feature: report stack traces on Objective-C runtime exceptions at startup

* startup now installs a stacktrace callback so universe failures print backtraces
* new mulle-stacktrace dependency added to clib.json


### 0.21.1

Various small improvements
