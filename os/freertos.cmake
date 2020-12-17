# Load library definitions
include(lib/freertos.cmake)
include(lib/clib-support.cmake)

set(PORT_DIR ${CMAKE_SOURCE_DIR}/os/freertos)

# FreeRTOSConfig.h is included globally
include_directories(${PORT_DIR})
target_sources(freertos PRIVATE
  ${PORT_DIR}/hooks.c
  ${PORT_DIR}/cyabs_freertos_helpers.c
)
target_link_libraries(freertos PRIVATE clib-support)

# Load application definitions
include(app/blinky-freertos.cmake)
