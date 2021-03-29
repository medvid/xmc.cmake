# ACMP IP is specific to XMC1
if(NOT XMC1 IN_LIST COMPONENTS)
  return()
endif()

project(acmp-cmp)

xmc_load_application(
  NAME mtb-example-xmc-acmp-cmp
  VERSION 1.0.0
)

xmc_add_executable(
  SOURCES
    ${APP_DIR}/main.c
)
