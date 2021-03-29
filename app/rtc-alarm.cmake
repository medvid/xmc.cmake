project(rtc-alarm)

xmc_load_application(
  NAME mtb-example-xmc-rtc-alarm
  VERSION 1.0.0
)

xmc_add_executable(
  SOURCES
    ${APP_DIR}/main.c
)
