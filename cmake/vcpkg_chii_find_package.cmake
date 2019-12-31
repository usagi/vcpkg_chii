include_guard()

include( ${CMAKE_CURRENT_LIST_DIR}/vcpkg_chii_enable.cmake )

if ( NOT VCPKG_CHII_ENABLE )
  return()
endif()

message( "-- [vcpkg_chii/find_package]: 'vcpkg_chii_find_package' function is [ ON ]." )

# @param 1 vcpkg_package_name a package name in vcpkg
# @param 2 (optional) cmake_package_name a package name in CMake; default = vcpkg_package_name
function( vcpkg_chii_find_package vcpkg_package_name )

  # Optional argument resolver
  set ( extra_macro_args ${ARGN} )
  list(LENGTH extra_macro_args num_extra_args)
  if ( ${num_extra_args} GREATER 0)
    list( GET extra_macro_args 0 cmake_package_name )
  else()
    set( cmake_package_name ${vcpkg_package_name} )
  endif()

  # Make list only once per cmake running
  if ( NOT DEFINED vcpkg_chii_list )
    execute_process( COMMAND vcpkg list --triplet ${VCPKG_TARGET_TRIPLET} OUTPUT_VARIABLE vcpkg_chii_list ERROR_QUIET )
    string( TOLOWER "${vcpkg_chii_list}" vcpkg_chii_list )
    #string( REGEX REPLACE ";" " " vcpkg_chii_list "${vcpkg_chii_list}")
    string( REGEX REPLACE "\r?\n" ";" vcpkg_chii_list "${vcpkg_chii_list}")
    set( vcpkg_chii_list ${vcpkg_chii_list} PARENT_SCOPE )
  endif()

  string( TOLOWER "${vcpkg_package_name}" vcpkg_package_name_lower )

  set( vcpkg_chii_found OFF )
  foreach( vcpkg_chii_line ${vcpkg_chii_list} )
    if ( vcpkg_chii_line MATCHES "^${vcpkg_package_name_lower}:" )
      set( vcpkg_chii_found ON )
      break()
    endif()
  endforeach()

  # line-first: (^|[\\n\\r])
  #if ( vcpkg_chii_list MATCHES "(^|[\\n\\r])${vcpkg_package_name_lower}:" )
  if ( vcpkg_chii_found )
    message( "-- [vcpkg_chii/find_package]: '${vcpkg_package_name}:${VCPKG_TARGET_TRIPLET}' is found." )
  else()
    message( "-- [vcpkg_chii/find_package]: '${vcpkg_package_name}:${VCPKG_TARGET_TRIPLET}' is not found. Thus vcpkg_chii try to install..." )
    execute_process( COMMAND vcpkg install ${vcpkg_package_name} --triplet ${VCPKG_TARGET_TRIPLET} RESULT_VARIABLE result )
    if ( result EQUAL 0 )
      message( "-- [vcpkg_chii/find_package]: '${vcpkg_package_name}:${VCPKG_TARGET_TRIPLET}' installation was succeeded, maybe. ( vcpkg result code is 0 )" )
    else()
      message( FATAL_ERROR "-- [vcpkg_chii/find_package]: '${vcpkg_package_name}:${VCPKG_TARGET_TRIPLET}' installation was failed. ( vcpkg result code is ${result} )" )
    endif()
  endif()

  find_package( ${cmake_package_name} CONFIG REQUIRED )

endfunction()
