include_guard()

include( ${CMAKE_CURRENT_LIST_DIR}/vcpkg_chii_enable.cmake )

if ( NOT VCPKG_CHII_ENABLE )
  return()
endif()

if ( DEFINED VCPKG_TARGET_TRIPLET )
  message( "-- [vcpkg_chii/auto-triplet]: VCPKG_TARGET_TRIPLET was set => ${VCPKG_TARGET_TRIPLET}" )
  return()
endif()

message( "-- [vcpkg_chii/auto-triplet]: VCPKG_TARGET_TRIPLET was not set. Thus vcpkg-chii try to set automatically using VCPKG_DEFAULT_TRIPLET environment variable." )

if ( NOT DEFINED ENV{VCPKG_DEFAULT_TRIPLET} )
  message( "-- [vcpkg_chii/auto-triplet]: *Note* VCPKG_DEFAULT_TRIPLET was not set. Thus also VCPKG_TARGET_TRIPLET will not set. ( Use environment default )" )
  message( "-- [vcpkg_chii/auto-triplet]: *Note* See also <https://github.com/microsoft/vcpkg/blob/master/docs/users/triplets.md#additional-remarks>")
  if ( WIN32 )
    set( VCPKG_TARGET_TRIPLET x86-windows CACHE STRING "Vcpkg target triplet (ex. x86-windows)" )
  elseif ( APPLE )
    set( VCPKG_TARGET_TRIPLET x64-osx CACHE STRING "Vcpkg target triplet (ex. x86-windows)" )
  elseif ( UNIX )
    set( VCPKG_TARGET_TRIPLET x64-linux CACHE STRING "Vcpkg target triplet (ex. x86-windows)" )
  else()
    message( FATAL_ERROR "-- [vcpkg_chii/auto-triplet]: *FATAL* vcpkg_chii could not know the platform default in the other of (Windows|OSX|Linux). Retry call `cmake` with `-DVCPKG_TARGET_TRIPLET=<your-platform-triplet>` argument." )
  endif()
else()
  set( VCPKG_TARGET_TRIPLET $ENV{VCPKG_DEFAULT_TRIPLET} CACHE STRING "Vcpkg target triplet (ex. x86-windows)" )
endif()

message( "-- [vcpkg_chii/auto-triplet]: VCPKG_TARGET_TRIPLET was set automatically => ${VCPKG_TARGET_TRIPLET}" )
