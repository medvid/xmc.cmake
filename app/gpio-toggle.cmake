project(gpio-toggle)

xmc_load_application(
  NAME mtb-example-xmc-gpio-toggle
  VERSION 1.0.0
)

xmc_add_executable(
  SOURCES
    ${APP_DIR}/main.c
)
