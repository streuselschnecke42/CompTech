cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)
project(LedPushbuttons C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

include_directories(${CMAKE_SOURCE_DIR})

add_executable(LedPushbuttons
  LedPushbuttons.S
  sdklink.c
)

pico_enable_stdio_uart(LedPushbuttons 0)
pico_enable_stdio_usb(LedPushbuttons 1)

target_link_libraries(LedPushbuttons pico_stdlib)

pico_add_extra_outputs(LedPushbuttons)
