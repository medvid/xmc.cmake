# DAC IP is specific to XMC4
if(NOT XMC4 IN_LIST COMPONENTS)
  return()
endif()

project(dac-sine)

xmc_load_application(
  NAME mtb-example-xmc-dac-sine
  VERSION 1.0.0
)

xmc_add_executable(
  SOURCES
    ${APP_DIR}/main.c
)
