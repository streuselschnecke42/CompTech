cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)
project(SimpleButtonsTwoSDK C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

include_directories(${CMAKE_SOURCE_DIR})

add_executable(SimpleButtonsOneSDK
  SimpleButtonsTwoSDK.S
  sdklink.c
)

pico_enable_stdio_uart(SimpleButtonsTwoSDK 0)
pico_enable_stdio_usb(SimpleButtonsTwoSDK 1)

pico_add_extra_outputs(SimpleButtonsTwoSDK)

target_link_libraries(SimpleButtonsTwoSDK pico_stdlib)
