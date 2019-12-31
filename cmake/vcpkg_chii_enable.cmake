include_guard()

if ( NOT DEFINED VCPKG_CHII_ENABLE )
  set( VCPKG_CHII_ENABLE ON CACHE BOOL "vcpkg-cmake-hyper-integration-injector enabling switch. ( default is ON )" )
endif()

message( "-- [vcpkg_chii]: vcpkg-cmake-hyper-integration-injector is [ ${VCPKG_CHII_ENABLE} ] ( VCPKG_CHII_ENABLE:BOOL )" )
