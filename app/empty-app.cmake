project(empty-app)

xmc_load_application(
  NAME mtb-example-xmc-empty-app
  VERSION 0.5.0
)

xmc_add_executable(
  SOURCES
    ${APP_DIR}/main.c
)
