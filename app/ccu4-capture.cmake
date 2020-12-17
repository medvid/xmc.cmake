# This application provides custom design.modus for the below boards
xmc_check_bsp(
  KIT_XMC14_BOOT_001
  KIT_XMC47_RELAX_V1
)

# BUG: retarget-io.c is not compatible with IAR
if(${TOOLCHAIN} STREQUAL IAR)
  return()
endif()

project(ccu4-capture)

xmc_load_application(
  NAME mtb-example-xmc-ccu4-capture
  VERSION 0.5.0
)

xmc_add_executable(
  SOURCES
    ${APP_DIR}/main.c
    ${APP_DIR}/retarget_io.h
    ${APP_DIR}/retarget_io.c
    ${APP_DIR}/ring_buffer.h
    ${APP_DIR}/ring_buffer.c
  DESIGN_MODUS
    ${APP_DIR}/COMPONENT_CUSTOM_DESIGN_MODUS/TARGET_${BSP_NAME}/design.modus
)
