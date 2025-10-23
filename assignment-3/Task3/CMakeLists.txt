cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)
project(SecondLedPushbuttons C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

include_directories(${CMAKE_SOURCE_DIR})

add_executable(SecondLedPushbuttons
  SecondLedPushbuttons.S
)

pico_enable_stdio_uart(SecondLedPushbuttons 0)
pico_enable_stdio_usb(SecondLedPushbuttons 1)

pico_add_extra_outputs(SecondLedPushbuttons)

target_link_libraries(SecondLedPushbuttons pico_stdlib)
