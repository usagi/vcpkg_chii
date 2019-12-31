cmake_minimum_required( VERSION 3.12 )

# Example of vcpkg-chii
#   You can use directly such as below, or also you can deploy into CMAKE_MODULE_PATH and use it without .cmake extension
include( ../cmake/vcpkg_chii.cmake )

project( y )

# Hint-1:
#   A package name of vcpkg is not case sensitive
#   A package name of CMake is case sensitive ( for find_package with case sensitive filesystem )
#   vcpkg_chii_find_package capable to a 2 arguments
#     argument-1: vcpkg_package_name
#     argument-2: cmake_package_name ( optional, default = vcpkg_package_name )
#   Therefore, using only a CMake package name is usually fine.
vcpkg_chii_find_package( Eigen3 )
# Hint-2:
#   Use one vcpkg_chii_find_package per package
#   Effect of vcpkg_chii_find_package is:
#     1. `vcpkg list` and check installation status
#     2. `vcpkg install` if needed
#     3. find_package (CMake)
# Hint-3:
#   If you got CMake error such as
#     Could not find a package configuration file provided by "gtest" with any of the following names:
#     the following names: 
#       gtestConfig.cmake
#       gtest-config.cmake
#   Then, you can find a correct CMake package name ( Module name ) with file searching maybe:
#     (in UNIX-like ): find $(dirname $(readlink -f $(which vcpkg)))/installed -iname "gtest*.cmake"
#     (in powershell): ls -r ((Split-Path (gcm vcpkg).Definition)+"/installed") | where { $_.Name -match "^eigen.*cmake" }
vcpkg_chii_find_package( GTest )

add_library( my_norm my_norm.cxx )
add_executable( my_test my_test.cxx )
add_dependencies( my_test my_norm )

# It's required.
# Eigen is a header only library but it will be required to enabling an include directory settings.
target_link_libraries( my_norm PRIVATE Eigen3::Eigen )

# It's required. gtest is not a header only library.
# But, GTest::gmock and GTest::gmock_main is not required in this case then:
target_link_libraries( my_test PRIVATE GTest::gtest GTest::gtest_main my_norm )

# These are CMake & gtest features
include( GoogleTest )
gtest_add_tests( TARGET my_test )
