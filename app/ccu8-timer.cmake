project(ccu8-timer)

xmc_load_application(
  NAME mtb-example-xmc-ccu8-timer
  VERSION 1.0.0
)

xmc_add_executable(
  SOURCES
    ${APP_DIR}/main.c
)
