# Download BSP sources from GitHub
xmc_load_bsp(
  NAME KIT_XMC14_BOOT_001
  VERSION 1.0.0
)

# Set target MPN
xmc_set_device(XMC1404-Q064x0200)

# Set J-Link target device name
xmc_set_jlink_device(XMC1404-0200)

# Set target CPU core
xmc_set_core(CM0)

# Load library definitions
include(lib/cmsis.cmake)
include(lib/core-lib.cmake)
include(lib/mtb-xmclib-cat3.cmake)

set(BSP_SOURCES
  ${BSP_DIR}/cybsp.h
  ${BSP_DIR}/cybsp.c
  ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC1400/Include/system_XMC1400.h
  ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC1400/Include/XMC1000_RomFunctionTable.h
  ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC1400/Include/XMC1400.h
  ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC1400/Source/system_XMC1400.c
)
set(BSP_LINK_LIBRARIES
  mtb-xmclib-cat3
)

if(${TOOLCHAIN} STREQUAL GCC)
  list(APPEND BSP_SOURCES
    ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC1400/Source/TOOLCHAIN_GCC_ARM/startup_XMC1400.S
    ${MTB_XMCLIB_CAT3_DIR}/Newlib/syscalls.c
  )
  set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_GCC_ARM/XMC1400x0200.ld)
elseif(${TOOLCHAIN} STREQUAL ARM)
  list(APPEND BSP_SOURCES
    ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC1400/Source/TOOLCHAIN_ARM/startup_XMC1400.s
  )
  set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_ARM/XMC1400x0200.sct)
elseif(${TOOLCHAIN} STREQUAL IAR)
  list(APPEND BSP_SOURCES
    ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC1400/Source/TOOLCHAIN_IAR/startup_XMC1400.s
  )
  set(BSP_LINKER_SCRIPT "${IAR_TOOLCHAIN_PATH}/config/linker/Infineon/XMC1404xxxxx200.icf")
elseif(${TOOLCHAIN} STREQUAL LLVM)
  list(APPEND BSP_SOURCES
    ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC1400/Source/TOOLCHAIN_GCC_ARM/startup_XMC1400.S
  )
  set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_GCC_ARM/XMC1400x0200.ld)
else()
  message(FATAL_ERROR "bsp: TOOLCHAIN ${TOOLCHAIN} is not supported.")
endif()

# Include BSP_DIR and CMSIS startup directories globally
include_directories(${BSP_DIR})
include_directories(${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC1400/Include)

# Add common definitions and components
xmc_add_component(BSP_DESIGN_MODUS)
xmc_add_component(CAT3)
xmc_add_component(XMC1)

# Define BSP library
add_library(bsp STATIC EXCLUDE_FROM_ALL ${BSP_SOURCES})
target_link_libraries(bsp PUBLIC ${BSP_LINK_LIBRARIES})

# Define custom recipes for BSP generated sources
xmc_add_bsp_design_modus(${BSP_DIR}/COMPONENT_BSP_DESIGN_MODUS/design.modus)
