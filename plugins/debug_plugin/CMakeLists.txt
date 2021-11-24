add_library(
    debug_plugin
    debug_plugin.cpp
    debug_plugin.hpp
    "${CMAKE_CURRENT_SOURCE_DIR}/../../libraries/debug_eos_vm/dwarf.cpp"
)

target_link_libraries(
    debug_plugin
    chain_plugin
    eosio_chain
    appbase)

target_include_directories(
    debug_plugin
    PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/../../libraries/abieos/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../libraries/debug_eos_vm/include"
)
