add_subdirectory(../chain)
add_subdirectory(pybind11)

add_library(py_eosio MODULE python_bindings.cpp)

find_package(Boost REQUIRED COMPONENTS 
    date_time
    filesystem
    system
    chrono
    iostreams
    unit_test_framework)


target_include_directories(
    py_eosio
    PUBLIC
    ${Boost_INCLUDE_DIRS}
    "${CMAKE_CURRENT_SOURCE_DIR}/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/../fc/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/../chain/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/../wasm-jit/Include"
    "${CMAKE_CURRENT_SOURCE_DIR}/../chainbase/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/../softfloat/source/include")

target_link_libraries(
    py_eosio
    PRIVATE
    pybind11::module pybind11::lto
    eosio_chain)


pybind11_extension(py_eosio)
pybind11_strip(py_eosio)

set_target_properties(py_eosio PROPERTIES CXX_VISIBILITY_PRESET "hidden"
                                         CUDA_VISIBILITY_PRESET "hidden")

