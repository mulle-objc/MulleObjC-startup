# MulleObjC-startup Library Documentation for AI
<!-- Keywords: objc, startup, universe, registration, stacktrace, static, runtime -->

## 1. Introduction & Purpose

- Provides the startup code needed to build executables that link against
  [MulleObjC](https://github.com/mulle-objc/MulleObjC) and nothing else.
  It supplies the required `__register_mulle_objc_universe` symbol so no
  larger Foundation-style startup library is needed.
- Solves: delivering the universe registration entrypoint and the actual
  "bang" (configuration) routine invoked at process startup to bring up the
  default MulleObjC universe.
- Key features: tiny static-only library, automatic universe registration,
  installs a stacktrace callback so Objective-C runtime exceptions print
  backtraces.
- A foundational link-time component of the mulle-objc ecosystem; depends on
  `MulleObjC` and `mulle-stacktrace`. Often superseded by the Foundation
  startup library in larger projects.

## 2. Key Concepts & Design Philosophy

- **Minimalism:** Only the pieces required to start an ObjC universe in an
  executable are provided; no runtime or class-library code is included.
- **Link-time provider:** The object file supplies the
  `__register_mulle_objc_universe` symbol that the MulleObjC runtime and
  linker expect. The implementation of that symbol is pulled in from
  MulleObjC's `mulle-objc-startup-private.inc`; this project provides the
  `bang` callback that registration invokes.
- **Default configuration:** Copies the default universe configuration via
  `mulle_objc_global_get_default_universeconfiguration()` and applies it with
  `mulle_objc_universe_configure()`. The allocator is not touched (it is
  already set on the universe), except optionally a test allocator looked up
  via `dlsym` when `MULLE_OBJC_TESTALLOCATOR_ENABLED` is set.
- **Exception reporting:** Installs `mulle_stacktrace_once` as the universe
  stacktrace callback through
  `mulle_objc_universe_set_stacktrace_callback()`, so failures print backtraces.
- **Static-only:** CMake enforces a static build
  (`BUILD_SHARED_LIBS` triggers a `FATAL_ERROR`).

## 3. Core API & Data Structures

This project does not ship public header files. Its public surface is
link-time symbols plus one compile-time macro. The only source file is
`src/MulleObjC-startup.m`.

### 3.1. `src/MulleObjC-startup.m`

#### Exported symbol: `__register_mulle_objc_universe`

Provided indirectly via the included `mulle-objc-startup-private.inc`
(supplied by the `MulleObjC` dependency). Verbatim signature:

```c
MULLE_C_GLOBAL  // voodoo
struct _mulle_objc_universe  *
   __register_mulle_objc_universe( mulle_objc_universeid_t universeid,
                                   char *universename)
```

- **Purpose:** Canonical universe registration entrypoint for the linker/runtime.
- **Behavior:**
  - Fetches the universe for the given id/name via
    `__mulle_objc_global_get_universe()`.
  - If already initialized, returns it unchanged.
  - Otherwise resolves a test allocator via `dlsym( RTLD_DEFAULT,
    "mulle_testallocator")` when `MULLE_OBJC_TESTALLOCATOR_ENABLED` is set.
  - Runs the bang sequence through `_mulle_objc_universe_bang()`.
- **Usage:** No source-level invocation needed; the symbol is picked up when
  the library is linked.

#### Referenced symbol: `mulle_objc_universe_set_stacktrace_callback`

Forward-declared locally (kept usable with older cached MulleObjC headers);
the symbol itself is supplied by `mulle-objc-runtime`. Verbatim declaration:

```c
MULLE_OBJC_RUNTIME_GLOBAL
void
   mulle_objc_universe_set_stacktrace_callback(
      struct _mulle_objc_universe *universe,
      void (*callback)( FILE *fp));
```

- **Purpose:** Installs a callback invoked to render stack traces when a
  runtime failure occurs.

#### Compile-time macro: `MULLE_OBJC__STARTUP_VERSION`

```c
#define MULLE_OBJC__STARTUP_VERSION  ((0UL << 20) | (22 << 8) | 0)
```

- Encodes the startup library version (22 << 8 = version 22.0). Matches the
  CMake project version 0.22.0.

#### Internal static routine: `bang`

```c
static void   bang( struct _mulle_objc_universe *universe,
                    struct mulle_allocator *allocator,
                    void *userinfo)
```

- Copies the default universe configuration and calls `MulleObjCBang()`
  (which is `mulle_objc_universe_configure()`), then registers
  `mulle_stacktrace_once` as the stacktrace callback.

## 4. Performance Characteristics

- Startup-only code: executes once during process initialization, then is
  effectively dormant. Negligible steady-state overhead.
- The test-allocation lookup occurs only when the
  `MULLE_OBJC_TESTALLOCATOR_ENABLED` environment variable is set.
- Thread-safety: designed to run during single-threaded process
  initialization; not intended to be invoked concurrently.

## 5. AI Usage Recommendations & Patterns

- **Best practices:**
  - Add `MulleObjC-startup` as a dependency and let link-time registration
    happen; do not attempt to duplicate or reimplement
    `__register_mulle_objc_universe`.
  - If you need stack traces on runtime exceptions, nothing to do — the
    startup library wires `mulle_stacktrace_once` in automatically.
- **Common pitfalls:**
  - Do not define your own `__register_mulle_objc_universe` symbol; this
    library already provides it and symbols would clash.
  - Do not link `MulleObjC-startup` together with a Foundation startup
    library; pick one startup provider.
  - The startup library must be built static; shared builds are rejected at
    CMake configure time.
- **Idiomatic usage:** Just depend on it via `mulle-sde add` / `clib install`
  and link. Legacy source imports of `<MulleObjC-startup/MulleObjC-startup.h>`
  are informational only — modern usage is link-based.

## 6. Integration Examples

### Example 1: Add to a mulle-sde project (recommended)

```sh
mulle-sde add github:mulle-objc/MulleObjC-startup
# then craft/run as usual; the __register_mulle_objc_universe symbol is linked in
mulle-sde run
```

### Example 2: Add sources with clib (legacy)

```sh
clib install --out src/mulle-objc mulle-objc/MulleObjC-startup
# add -isystem src/mulle-objc to CFLAGS (or in cmake:
#   include_directories( BEFORE SYSTEM src/mulle-objc))
```

### Example 3: Link as cmake subproject

```cmake
add_subdirectory( stash/MulleObjC-startup)
# include the startup library in your executable target
target_link_libraries( ${PROJECT_NAME} PUBLIC MulleObjC-startup)
```

## 7. Dependencies

Direct `clib.json` dependencies:

- `mulle-core/mulle-stacktrace` (provides `mulle_stacktrace_once`)
- `mulle-objc/MulleObjC` (provides the runtime and the
  `mulle-objc-startup-private.inc` registration glue)

For linking, the runtime (via `mulle-objc-runtime`) and the
`mulle-atinit`/`mulle-atexit` mechanisms are also relied upon.