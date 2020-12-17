project(gpio-toggle)

xmc_load_application(
  NAME mtb-example-xmc-gpio-toggle
  VERSION 0.5.0
)

xmc_add_executable(
  SOURCES
    ${APP_DIR}/main.c
)
