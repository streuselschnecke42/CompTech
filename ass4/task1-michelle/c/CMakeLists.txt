cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)
project(ButtonSDK C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

include_directories(${CMAKE_SOURCE_DIR})

add_executable(ButtonSDK
  ButtonSDK.c
)

pico_enable_stdio_uart(ButtonSDK 0)
pico_enable_stdio_usb(ButtonSDK 1)

pico_add_extra_outputs(ButtonSDK)

target_link_libraries(ButtonSDK pico_stdlib)
