# Download BSP sources from GitHub
xmc_load_bsp(
  NAME KIT_XMC47_RELAX_V1
  VERSION 1.0.0
)

# Set target MPN
xmc_set_device(XMC4700-F144x2048)

# Set J-Link target device name
xmc_set_jlink_device(XMC4700-2048)

# Set target CPU core
xmc_set_core(CM4)

# Set target VFP
xmc_set_vfp(SOFTFP)

# Load library definitions
include(lib/cmsis.cmake)
include(lib/core-lib.cmake)
include(lib/mtb-xmclib-cat3.cmake)

set(BSP_SOURCES
  ${BSP_DIR}/cybsp.h
  ${BSP_DIR}/cybsp.c
  ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC4700/Include/system_XMC4700.h
  ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC4700/Include/XMC4700.h
  ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC4700/Source/system_XMC4700.c
)
set(BSP_LINK_LIBRARIES
  mtb-xmclib-cat3
)

if(${TOOLCHAIN} STREQUAL GCC)
  list(APPEND BSP_SOURCES
    ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC4700/Source/TOOLCHAIN_GCC_ARM/startup_XMC4700.S
    ${MTB_XMCLIB_CAT3_DIR}/Newlib/syscalls.c
  )
  set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_GCC_ARM/XMC4700x2048.ld)
elseif(${TOOLCHAIN} STREQUAL ARM)
  list(APPEND BSP_SOURCES
    ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC4700/Source/TOOLCHAIN_ARM/startup_XMC4700.s
  )
  set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_ARM/XMC4700x2048.sct)
elseif(${TOOLCHAIN} STREQUAL IAR)
  list(APPEND BSP_SOURCES
    ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC4700/Source/TOOLCHAIN_IAR/startup_XMC4700.s
  )
  set(BSP_LINKER_SCRIPT "${IAR_TOOLCHAIN_PATH}/config/linker/Infineon/XMC4700xxxxx2048.icf")
elseif(${TOOLCHAIN} STREQUAL LLVM)
  list(APPEND BSP_SOURCES
    ${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC4700/Source/TOOLCHAIN_GCC_ARM/startup_XMC4700.S
  )
  set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_GCC_ARM/XMC4700x2048.ld)
else()
  message(FATAL_ERROR "bsp: TOOLCHAIN ${TOOLCHAIN} is not supported.")
endif()

# Include BSP_DIR and CMSIS startup directories globally
include_directories(${BSP_DIR})
include_directories(${MTB_XMCLIB_CAT3_DIR}/CMSIS/Infineon/COMPONENT_XMC4700/Include)

# Add common definitions and components
xmc_add_component(BSP_DESIGN_MODUS)
xmc_add_component(CAT3)
xmc_add_component(XMC4)

# Define BSP library
add_library(bsp STATIC EXCLUDE_FROM_ALL ${BSP_SOURCES})
target_link_libraries(bsp PUBLIC ${BSP_LINK_LIBRARIES})

# Define custom recipes for BSP generated sources
xmc_add_bsp_design_modus(${BSP_DIR}/COMPONENT_BSP_DESIGN_MODUS/design.modus)
