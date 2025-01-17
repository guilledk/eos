option(PORTABLE CACHE ON)               # rocksdb: don't use sse4.2
option(WITH_GFLAGS CACHE OFF)           # rocksdb: don't use gflags
option(WITH_TESTS CACHE OFF)            # rocksdb: don't build this
option(WITH_TOOLS CACHE OFF)            # rocksdb: don't build this
option(WITH_BENCHMARK_TOOLS CACHE OFF)  # rocksdb: don't build this
option(FAIL_ON_WARNINGS CACHE OFF)      # rocksdb: stop the madness: warnings change over time

#on Linux, rocksdb will monkey with CMAKE_INSTALL_PREFIX is this is on
set(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT OFF)
# rocksdb disables USE_RTTI for release build, which breaks
# exception handling on MacOS.
if(APPLE)
  set(USE_RTTI ON)
endif()

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

add_subdirectory( fc )
add_subdirectory( builtins )
add_subdirectory( softfloat )
add_subdirectory( chainbase )
add_subdirectory( wasm-jit )
# add_subdirectory( appbase )
add_subdirectory( chain )
add_subdirectory( version )
add_subdirectory( state_history )
add_subdirectory( abieos )
add_subdirectory( rocksdb )
add_subdirectory( chain_kv )
add_subdirectory( se-helpers )

set(USE_EXISTING_SOFTFLOAT ON CACHE BOOL "use pre-exisiting softfloat lib")
set(ENABLE_TOOLS OFF CACHE BOOL "Build tools")
set(ENABLE_TESTS OFF CACHE BOOL "Build tests")
set(ENABLE_ADDRESS_SANITIZER OFF CACHE BOOL "Use address sanitizer")
set(ENABLE_UNDEFINED_BEHAVIOR_SANITIZER OFF CACHE BOOL "Use UB sanitizer")
set(ENABLE_PROFILE OFF CACHE BOOL "Enable for profile builds")
if(eos-vm IN_LIST EOSIO_WASM_RUNTIMES OR eos-vm-jit IN_LIST EOSIO_WASM_RUNTIMES)
add_subdirectory( eos-vm )
endif()

set(ENABLE_STATIC OFF)
set(CMAKE_MACOSX_RPATH OFF)
set(BUILD_ONLY_LIB ON CACHE BOOL "Library only build")

add_subdirectory( testing )

