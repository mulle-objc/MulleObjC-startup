# MulleObjC-startup Library Documentation for AI
<!-- Keywords: objc, startup, runtime, static, universe, registration -->

## 1. Introduction & Purpose

- Provides a small static startup library for MulleObjC-based executables.  It supplies the required runtime registration symbol so an executable can link only against MulleObjC (and not a larger Foundation startup).
- Solves: delivering the __register_mulle_objc_universe symbol and wired-in startup sequence (atinit/atexit hooks) needed to bring the MulleObjC runtime up in simple executables.
- Key features: tiny static startup, automatic registration, depends on MulleObjC.

## 2. Key Concepts & Design Philosophy

- Minimalism: only the startup pieces required for an executable are provided; not a full Foundation runtime.
- Link-time provider: this library's object file provides the universe registration symbol that the runtime and linker expect.
- Uses project-wide default universe configuration (copies default config and invokes MulleObjCBang).
- Static-only: intended to be built/linked as a static library (CMake enforces this).

## 3. Core API & Data Structures

This project does not ship public .h headers. The primary interface is link-time: symbols and compiled objects supplied by the library.

- __register_mulle_objc_universe (exported symbol)
  - Purpose: the canonical registration entrypoint that makes the ObjC universe available to an executable at startup/link time.
  - Usage: provided by the library when linked; no source-level invocation required in typical projects.

- MULLE_OBJC__STARTUP_VERSION (macro)
  - Purpose: encodes the startup library version.
  - Usage: available in compiled objects for version checks.

- Internal startup routine
  - Copies the default universe configuration and calls MulleObjCBang(universe, allocator, &config).
  - Registers atinit/atexit hooks so startup and teardown happen automatically.

## 4. Performance Characteristics

- Extremely small and fast; only executed once during process startup.
- Overhead: negligible runtime cost beyond the normal ObjC runtime initialization.
- Thread-safety: startup sequence runs during single-threaded process initialization; not intended to be invoked concurrently.

## 5. AI Usage Recommendations & Patterns

- Best practice: Add this library as a dependency and let link-time registration occur; do not attempt to duplicate or reimplement the registration symbol.
- Avoid calling internal/private symbols from application code — treat the library as a link-time provider.
- When debugging startup issues, inspect the default universe configuration via MulleObjC APIs rather than modifying this library.

## 6. Integration Examples

### Example 1: Add MulleObjC-startup to a mulle-sde project (recommended)

```sh
mulle-sde add github:mulle-objc/MulleObjC-startup
# then build/install as usual with mulle-sde craft / install
```

### Example 2: CMake link snippet (from README)

```cmake
add_subdirectory( stash/MulleObjC-startup)
# link the startup library into your executable
target_link_libraries( ${PROJECT_NAME} PUBLIC MulleObjC-startup)
```

### Example 3: Legacy include (informational)

```c
// Legacy projects sometimes imported a header; modern usage is link-based
#import <MulleObjC-startup/MulleObjC-startup.h>
// No explicit call necessary; linking the library supplies registration
```

## 7. Dependencies

- Direct dependency (clib.json): mulle-objc/MulleObjC
- At runtime/link-time: relies on the MulleObjC runtime and the project's atinit/atexit mechanism (mulle-atinit, mulle-atexit).

