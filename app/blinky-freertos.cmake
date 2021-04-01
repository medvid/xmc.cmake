project(blinky-freertos)

xmc_load_application(
  NAME mtb-example-xmc-blinky-freertos
  VERSION 1.0.0
)

xmc_add_executable(
  SOURCES
    ${APP_DIR}/main.c
  LINK_LIBRARIES
    freertos
)
