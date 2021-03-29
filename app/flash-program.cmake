# This application relies board-specific XMC_SECTOR_ADDR
xmc_check_bsp(
  KIT_XMC14_BOOT_001
  KIT_XMC47_RELAX_V1
)

project(flash-program)

xmc_load_application(
  NAME mtb-example-xmc-flash-program
  VERSION 1.0.0
)

xmc_add_executable(
  SOURCES
    ${APP_DIR}/main.c
)
