cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)
project(DisapointmentSDK C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

include_directories(${CMAKE_SOURCE_DIR})

add_executable(DisapointmentSDK
  DisapointmentSDK.S
  sdklink.c
)

pico_enable_stdio_uart(DisapointmentSDK 0)
pico_enable_stdio_usb(DisapointmentSDK 1)

pico_add_extra_outputs(DisapointmentSDK)

target_link_libraries(DisapointmentSDK pico_stdlib)
