cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)
project(test_project C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

include_directories(${CMAKE_SOURCE_DIR})

add_executable(DisplayCounterSDK
  DisplayCounterSDK.S
  sdklink.c
)

pico_enable_stdio_uart(DisplayCounterSDK 0)
pico_enable_stdio_usb(DisplayCounterSDK 1)

pico_add_extra_outputs(DisplayCounterSDK)

target_link_libraries(DisplayCounterSDK pico_stdlib)
