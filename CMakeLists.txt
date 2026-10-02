cmake_minimum_required( VERSION 3.13...99.99)

project( MulleObjC-startup VERSION 0.23.0 LANGUAGES C)

# MulleObjC-startup is a force-linkable initialization library: its
# atinit/atexit constructors must be whole-archived into every consumer, even
# when no symbol of it is referenced directly. Objective-C projects want this
# ON. A plain C project that does not rely on load-time constructors should
# turn it OFF, so its consumers do not pull in the whole archive.
option( MULLE_LIBRARY_FORCE_LINK
        "Force-link MulleObjC-startup into consumers"
        ON)


### mulle-sde environment

# add cmake module paths to search path
list( INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_SOURCE_DIR}/cmake/share")
list( INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_SOURCE_DIR}/cmake/reflect")
list( INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include( Environment)

include( Files)

### Library

if( HEADERS_PHASE)
   # short cut out
   if( NOT COMPILE_PHASE AND NOT LINK_PHASE)
      return()
   endif()
endif()

if( BUILD_SHARED_LIBS)
   message( FATAL_ERROR "Startup library must be built static")
endif()

# this is an option
set( CREATE_OBJC_LOADER_INC OFF)

if( LINK_PHASE)
   include( Dependencies OPTIONAL)
endif()

unset( STARTUP_LIBRARY_NAME)

include( Library)

# use LIBRARY_COMPILE_TARGET for compiler options
target_compile_definitions( "${LIBRARY_COMPILE_TARGET}" PUBLIC)
target_compile_options( "${LIBRARY_COMPILE_TARGET}" PUBLIC  -Wall)
# use LIBRARY_LINK_TARGET for linker options
if( LINK_PHASE)
   target_link_options( "${LIBRARY_LINK_TARGET}" PUBLIC)
endif()

include( InstallLibrary)

if( LINK_PHASE)
   set(SRC_SHARE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/share")
   if( EXISTS "${SRC_SHARE_DIR}")
      install(
         DIRECTORY "${SRC_SHARE_DIR}/"
         DESTINATION "${INSTALL_SHARE_DIR}"
         USE_SOURCE_PERMISSIONS
      )
   endif()
   include( AddSubdirectorySupport)
   include( FindPackageSupport)
   include( AllLoadSupport)
endif() 

include( FinalOutput OPTIONAL)
