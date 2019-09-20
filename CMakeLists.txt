cmake_minimum_required( VERSION 3.1)

project( MulleObjC-startup C)


### mulle-sde environment

# add cmake module paths to search path
list( INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/cmake/share")
list( INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/cmake")

include( Environment)

include( Files)

### Library

if( HEADERS_PHASE)
   #
   # voodoo: even if nothing gets installed we need some "install" targets
   #         here, so that the ninja file actually understands the install
   #         command.
   #
   #install( FILES ${INSTALL_PUBLIC_HEADERS}  DESTINATION "include/${PROJECT_NAME}")
   #install( FILES ${INSTALL_PRIVATE_HEADERS} DESTINATION "include/${PROJECT_NAME}/private")
   install( FILES ${CMAKE_INCLUDES}          DESTINATION "include/${PROJECT_NAME}/cmake")

   # short cut out
   if( NOT COMPILE_PHASE AND NOT LINK_PHASE)
      return()
   endif()
endif()

if( LINK_PHASE)
   include( Dependencies OPTIONAL)
endif()

if( BUILD_SHARED_LIBS)
   message( FATAL_ERROR "Startup library must be built static")
endif()

unset( STARTUP_LIBRARY_NAME)

# this is an option
set( CREATE_OBJC_LOADER_INC OFF)

include( Library)
include( InstallLibrary)
include( FinalOutput OPTIONAL)
