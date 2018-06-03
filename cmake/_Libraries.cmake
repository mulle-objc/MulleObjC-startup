# cmake/_Libraries.cmake is generated by `mulle-sde`. Edits will be lost.
#
if( MULLE_TRACE_INCLUDE)
   message( STATUS "# Include \"${CMAKE_CURRENT_LIST_FILE}\"" )
endif()

if( NOT MINGW)
   if( NOT DL_LIBRARY)
      find_library( DL_LIBRARY NAMES dl dlfcn)
      message( STATUS "DL_LIBRARY is ${DL_LIBRARY}")
   
      # the order looks ascending, but due to the way this file is read
      # it ends up being descending, which is what we need
      if( DL_LIBRARY)
         set( OS_SPECIFIC_LIBRARIES
            ${OS_SPECIFIC_LIBRARIES}
            ${DL_LIBRARY}
            CACHE INTERNAL "need to cache this"
         )
         # temporarily expand CMAKE_MODULE_PATH
         get_filename_component( _TMP_DL_ROOT "${DL_LIBRARY}" DIRECTORY)
         get_filename_component( _TMP_DL_ROOT "${_TMP_DL_ROOT}" DIRECTORY)
   
         # search for DependenciesAndLibraries.cmake to include
         foreach( _TMP_DL_NAME in dl,dlfcn)
            set( _TMP_DL_DIR "${_TMP_DL_ROOT}/include/${_TMP_DL_NAME}/cmake")
            # use explicit path to avoid "surprises"
            if( EXISTS "${_TMP_DL_DIR}/DependenciesAndLibraries.cmake")
               unset( DL_DEFINITIONS)
               list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_DL_DIR}")
               include( "${_TMP_DL_DIR}/DependenciesAndLibraries.cmake")
               list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_DL_DIR}")
               set( INHERITED_DEFINITIONS
                  ${INHERITED_DEFINITIONS}
                  ${DL_DEFINITIONS}
                  CACHE INTERNAL "need to cache this"
               )
               break()
            endif()
         endforeach()
      else()
         message( FATAL_ERROR "DL_LIBRARY was not found")
      endif()
   endif()
endif()


if( MINGW)
   if( NOT PSAPI_LIBRARY)
      find_library( PSAPI_LIBRARY NAMES psapi)
      message( STATUS "PSAPI_LIBRARY is ${PSAPI_LIBRARY}")
   
      # the order looks ascending, but due to the way this file is read
      # it ends up being descending, which is what we need
      if( PSAPI_LIBRARY)
         set( OS_SPECIFIC_LIBRARIES
            ${OS_SPECIFIC_LIBRARIES}
            ${PSAPI_LIBRARY}
            CACHE INTERNAL "need to cache this"
         )
         # temporarily expand CMAKE_MODULE_PATH
         get_filename_component( _TMP_PSAPI_ROOT "${PSAPI_LIBRARY}" DIRECTORY)
         get_filename_component( _TMP_PSAPI_ROOT "${_TMP_PSAPI_ROOT}" DIRECTORY)
   
         # search for DependenciesAndLibraries.cmake to include
         foreach( _TMP_PSAPI_NAME in psapi)
            set( _TMP_PSAPI_DIR "${_TMP_PSAPI_ROOT}/include/${_TMP_PSAPI_NAME}/cmake")
            # use explicit path to avoid "surprises"
            if( EXISTS "${_TMP_PSAPI_DIR}/DependenciesAndLibraries.cmake")
               unset( PSAPI_DEFINITIONS)
               list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_PSAPI_DIR}")
               include( "${_TMP_PSAPI_DIR}/DependenciesAndLibraries.cmake")
               list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_PSAPI_DIR}")
               set( INHERITED_DEFINITIONS
                  ${INHERITED_DEFINITIONS}
                  ${PSAPI_DEFINITIONS}
                  CACHE INTERNAL "need to cache this"
               )
               break()
            endif()
         endforeach()
      else()
         message( FATAL_ERROR "PSAPI_LIBRARY was not found")
      endif()
   endif()
endif()