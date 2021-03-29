# This application provides custom design.modus for the below boards
xmc_check_bsp(
  KIT_XMC14_BOOT_001
  KIT_XMC47_RELAX_V1
)

project(i2c-master-slave)

xmc_load_application(
  NAME mtb-example-xmc-i2c-master-slave
  VERSION 1.0.0
)

xmc_add_executable(
  SOURCES
    ${APP_DIR}/main.c
  DESIGN_MODUS
    ${APP_DIR}/COMPONENT_CUSTOM_DESIGN_MODUS/TARGET_${BSP_NAME}/design.modus
)
