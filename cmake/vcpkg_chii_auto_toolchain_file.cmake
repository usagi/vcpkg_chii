include_guard()

include( ${CMAKE_CURRENT_LIST_DIR}/vcpkg_chii_enable.cmake )

if ( NOT VCPKG_CHII_ENABLE )
  return()
endif()

if ( DEFINED CMAKE_TOOLCHAIN_FILE )
  message( "-- [vcpkg_chii/auto-toolchain-file]: CMAKE_TOOLCHAIN_FILE was set => ${CMAKE_TOOLCHAIN_FILE}" )
  return()
endif()

message( "-- [vcpkg_chii/auto-toolchain-file]: CMAKE_TOOLCHAIN_FILE was not set. Thus vcpkg_chii try to set automatically using vcpkg installed path." )

if ( WIN32 )
  execute_process( COMMAND powershell -Command "Split-Path (gcm vcpkg).Definition" OUTPUT_VARIABLE CMAKE_TOOLCHAIN_FILE ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE )
elseif ( APPLE OR UNIX )
  execute_process( COMMAND sh -c "dirname $( readlink -f $( which vcpkg ) )" OUTPUT_VARIABLE CMAKE_TOOLCHAIN_FILE ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE )
else ()
  message( FATAL_ERROR "-- [vcpkg_chii/auto-toolchain-file]: *FATAL* vcpkg_chii could not retrieve the platform such as (Windows|OSX|Linux) then vcpkg_chii could not set CMAKE_TOOLCHAIN_FILE automatically. Retry call `cmake` with `-DCMAKE_TOOLCHAIN_FILE=<your-vcpkg-toolchain-file>` argument." )
endif()

if ( CMAKE_TOOLCHAIN_FILE STREQUAL "" )
  message( FATAL_ERROR "-- [vcpkg_chii/auto-toolchain-file]: *ERROR* vcpkg is not found. ( Forgot to set PATH environment variable or not installed yet? )" )
endif()

set( CMAKE_TOOLCHAIN_FILE "${CMAKE_TOOLCHAIN_FILE}\\scripts\\buildsystems\\vcpkg.cmake" CACHE FILEPATH "Path to toolchain file supplied to ``cmake(1)``." )
message( "-- [vcpkg_chii/auto-toolchain-file]: CMAKE_TOOLCHAIN_FILE was set automatically => ${CMAKE_TOOLCHAIN_FILE}" )
