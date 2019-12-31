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

1. Get the `.cmake` file(s) into your project or CMake module directory <cmake>
2. `include` in your `CMakeLists.txt` ( See also <example/CMakeLists.txt> in the example project )
3. Use `vcpkg_chii_find_package` instead of `find_package` ( See also the example too )

```cmake
# With vcpkg-chii features ( full automatically package resolving with vcpkg and vcpkg-chii! )
mkdir build && pushd build && cmake ..
```

```
# Without vcpkg-chii features ( for use if end-user need the other package manager or manual controlling )
mkdir build && pushd build && cmake .. -DVCPKG_CHII_ENABLE=OFF
```

### Example 

- <example>

## License

[MIT](LICENSE)

## Author

Usagi Ito <the@usagi.network> <https://twitter.com/USAGI_WRP> <https://www.facebook.com/usagi.wrp>
