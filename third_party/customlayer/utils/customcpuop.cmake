cmake_minimum_required(VERSION 2.8)
cmake_policy(SET CMP0048 NEW)
cmake_policy(SET CMP0046 NEW)

set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install CACHE PATH "Install prefix")
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

project(cpu-ops LANGUAGES CXX VERSION 1.0.0)
if (CMAKE_VERSION VERSION_LESS 3.12)
  set(CMAKE_PROJECT_VERSION 1.0.0)
endif()

file(GLOB_RECURSE srcs cpu_src/*.cpp)
add_library(customcpuop SHARED ${srcs})
target_include_directories(customcpuop PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
                                        ${CMAKE_CURRENT_SOURCE_DIR}/include/custom_cpu)
target_compile_features(customcpuop PUBLIC cxx_std_11)
set_target_properties(customcpuop PROPERTIES SOVERSION ${CMAKE_PROJECT_VERSION})


set(ENABLE_TESTING OFF CACHE BOOL "Enable testings")
if (ENABLE_TESTING)
    enable_testing()
    add_subdirectory(tests)
endif()

install(TARGETS customcpuop
    LIBRARY DESTINATION lib
    COMPONENT libsophon)
install(FILES
    include/bmcpu.h
    include/customcpu_common.h
    DESTINATION include
    COMPONENT libsophon)