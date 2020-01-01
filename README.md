# vcpkg_chii: vcpkg cmake hyper integration injector

*Let's do more easy, make it more convenient for vcpkg and CMake users.*

This is a simple .cmake gimmicks for CMake and vcpkg:

1. You can use only ( in ideal ) `cmake ..` without brabrabra options!
   1. Set `VCPKG_TARGET_TRIPLET` automatically from `VCPKG_DEFAULT_TRIPLET` environment variable or vcpkg default if not set.
   2. Set `CMAKE_TOOLCHAIN_FILE` automatically from path of `vcpkg` if not set.
2. You don't care library pre-installation such as `vcpkg install <library>`!
   1. Your required libraries will be install automatically in a cmake time.

*Note*: This is a very comfortable hack. But, I author strongly recommend that you explicitly information to your app user who build from a sources if you include this features.

## Usage

### Usage 1-A: With bootstrap.(sh|ps1) // recomended!

1. cd <your-project-root>
2. bootstrap:
    - (Unix-like ): `curl -s https://raw.githubusercontent.com/usagi/vcpkg_chii/master/bootstrap.sh | sh`
    - (powershell): `powershell -c "(New-Object Net.WebClient).Proxy.Credentials=[Net.CredentialCache]::DefaultNetworkCredentials;iwr('https://raw.githubusercontent.com/usagi/vcpkg_chii/master/bootstrap.ps1')|iex"`

Notes:

- Unix-like method be required `sh` & `curl`.
- bootstrap.sh source code is here -> [bootstrap.sh](bootstrap.sh).
- bootstrap.ps1 source code is here -> [bootstrap.ps1](bootstrap.ps1).

### Usage 1-B: Without bootstrap, in manually

- Get these `.cmake` file(s) into your project or CMake module directory [cmake](./cmake)
   1. [cmake/vcpkg.chii.cmake](cmake/vcpkg.chii.cmake)
   2. [cmake/vcpkg.chii_enable.cmake](cmake/vcpkg.chii_enable.cmake)
   3. [cmake/vcpkg.chii_auto_triplet.cmake](cmake/vcpkg.chii_auto_triplet.cmake)
   4. [cmake/vcpkg.chii_auto_toolchain_file.cmake](cmake/vcpkg.chii_auto_toolchain_file.cmake)
   5. [cmake/vcpkg.chii_find_package.cmake](cmake/vcpkg.chii_find_package.cmake)

### Usage 2: Inject vcpkg_chii into your CMakeLists.txt

1. `include` in your `CMakeLists.txt` ( See also [example/CMakeLists.txt](example/CMakeLists.txt) in the example project )
   - e.g. `include(cmake/vcpkg_chii.cmake)`
2. Use `vcpkg_chii_find_package` instead of `find_package` ( See also the example too )
   - e.g. `find_package( Eigen3 )`, `find_package( GTest )`, ...

### Usage 3: cmake time

```cmake
# With vcpkg_chii features ( full automatically package resolving with vcpkg and vcpkg-chii! )
mkdir build && pushd build && cmake ..
```

```cmake
# Without vcpkg_chii features ( for use if end-user need the other package manager or manual controlling )
mkdir build && pushd build && cmake .. -DVCPKG_CHII_ENABLE=OFF
```

### Example 

- [example](./example)

*Note*: Need [vcpkg](https://github.com/microsoft/vcpkg) and [CMake](https://cmake.org/) installed environment.

1. `cd example`
2. `mkdir build`
3. `cd build`
4. `cmake ..` // no needs brabrabra...
5. `cmake --build .`
6. `ctest` or `./my_test`

## License

[MIT](LICENSE)

## Author

Usagi Ito <the@usagi.network> <https://twitter.com/USAGI_WRP> <https://www.facebook.com/usagi.wrp>
