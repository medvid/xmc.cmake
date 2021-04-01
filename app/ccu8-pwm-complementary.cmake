project(ccu8-pwm-complementary)

xmc_load_application(
  NAME mtb-example-xmc-ccu8-pwm-complementary
  VERSION 1.0.0
)

xmc_add_executable(
  SOURCES
    ${APP_DIR}/main.c
)
