# CMake based build system for Infineon XMC designs

[![Build Status](https://dev.azure.com/vmedvid/xmc.cmake/_apis/build/status/medvid.xmc.cmake?branchName=master)](https://dev.azure.com/vmedvid/xmc.cmake/_build/latest?definitionId=4&branchName=master)

## Prerequisites

* ModusToolbox 2.2.1
* CMake >= 3.16
* Ninja build system

### Install prerequisites - Windows

1. Download and install ModusToolbox 2.2:

    [https://www.cypress.com/ModusToolboxForWindows][ModusToolboxForWindows]

2. Download and install ModusToolbox 2.2.1 (patch on top of 2.2):

    [https://www.cypress.com/file/515781/download][ModusToolboxForWindows-2.2.1]

3. Download and install J-Link Software:

    https://www.segger.com/downloads/jlink/JLink_Windows.exe

4. Download and install the latest Git for Windows:

    https://gitforwindows.org/

5. Download and install the latest CMake win64-x64 Installer:

    https://cmake.org/download/

6. Download Ninja executable, add to user PATH:

    https://github.com/ninja-build/ninja/releases

    CLI example: to install Ninja 1.10.0 to %LOCALAPPDATA%\Programs\Ninja, execute the below commands in Git Bash terminal:

        curl -fsSL https://github.com/ninja-build/ninja/releases/download/v1.10.0/ninja-win.zip -o $TMPDIR/ninja-win.zip
        mkdir -p $LOCALAPPDATA/Programs/Ninja
        unzip $TMPDIR/ninja-win.zip -d $LOCALAPPDATA/Programs/Ninja

    Then add %LOCALAPPDATA%\Programs\Ninja to user PATH in Windows advanced system settings.

7. _(Optional)_ Download and install the latest GNU Arm Embedded toolchain:

    https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

    Installation path assumed in this guide:

        C:/Program Files (x86)/GNU Arm Embedded Toolchain/9 2020-q2-update

8. _(Optional)_ Download and install Arm Compiler 6:

    https://developer.arm.com/tools-and-software/embedded/arm-compiler/downloads/version-6

    Example installation path:

        C:/Program Files/ARMCompiler6.13

    Arm Compiler 6 is also bundled with Keil uVision 5 IDE:

    https://www.keil.com/arm/

    Installation path assumed in this document:

        C:/Keil_v5/ARM/ARMCLANG

    Note: valid license is required to use the Arm Compiler.

9. _(Optional)_ Download and install IAR Embedded Workbench for ARM:

    https://www.iar.com/iar-embedded-workbench/#!?architecture=Arm

    Installation path assumed in this document:

        C:\Program Files (x86)\IAR Systems\Embedded Workbench 8.4

    Note: valid license is required to use the IAR Compiler.

### Install prerequisites - macOS

1. Download and install ModusToolbox 2.2:

    [https://www.cypress.com/ModusToolboxForMac][ModusToolboxForMac]

2. Download and install ModusToolbox 2.2.1 (patch on top of 2.2):

    [https://www.cypress.com/file/515776/download][ModusToolboxForMac-2.2.1]

3. Download and install J-Link Software:

    https://www.segger.com/downloads/jlink/JLink_MacOSX.pkg

4. Install Xcode - this provides git client

5. Download and install Homebrew Package Manager:

    https://brew.sh

6. Install CMake and Ninja using Homebrew:

    brew install cmake ninja

7. _(Optional)_ Download and install the latest GNU Arm Embedded toolchain:

    https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

    Installation path assumed in this guide:

        $HOME/Applications/gcc-arm-none-eabi-9-2020-q2-update

### Install prerequisites - Linux

1. Download and install ModusToolbox 2.2:

    [https://www.cypress.com/ModusToolboxForLinux][ModusToolboxForLinux]

2. Download and install ModusToolbox 2.2.1 (patch on top of 2.2):

    [https://www.cypress.com/file/515771/download][ModusToolboxForLinux-2.2.1]

3. Download and install J-Link Software:

    https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb

4. Download and install Git, CMake>=3.16 and Ninja using the system package manager.

    Example for Ubuntu 20.04:

        sudo apt install git cmake ninja-build

    Note: Ubuntu 18.04 provides an old version CMake, not compatible with CMake recipes in this repo.
    To download latest CMake package, follow the instructions at https://apt.kitware.com.

5. _(Optional)_ Download and install the latest GNU Arm Embedded toolchain:

    https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

    Installation path assumed in this guide:

        /opt/gcc-arm-none-eabi-9-2020-q2-update

    CLI installation example:

        curl -fsSL https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2 -o /tmp/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2
        sudo tar -C /opt -xjf /tmp/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2

## Quick Start Guide - CLI

1. Open interactive terminal, for example Git Bash on Windows.

2. Check the prerequisite tools were properly installed and added to PATH:

        cmake --version
        ninja --version

3. Clone this repo:

        git clone https://github.com/medvid/xmc.cmake
        cd xmc.cmake

4. Generate Ninja build rules using CMake. Example that generates build recipes for bare-metal applications targeting KIT_XMC14_BOOT_001 board and GCC toolchain:

        cmake -G Ninja -S . -B build/TARGET_KIT_XMC14_BOOT_001/NOOS/GCC/Debug \
            -DTARGET=KIT_XMC14_BOOT_001 -DOS=NOOS -DTOOLCHAIN=GCC \
            -DCMAKE_BUILD_TYPE=Debug

5. Build all applications enabled for the selected TARGET and OS combination:

        cmake --build build/KIT_XMC14_BOOT_001/NOOS/GCC/Debug

6. Program gpio-toggle application to the XMC MCU:

        cmake --build build/KIT_XMC14_BOOT_001/NOOS/GCC/Debug --target gpio-toggle_PROGRAM

## Usage - Visual Studio Code

1. Install Visual Studio Code:

    https://aka.ms/vscode

2. Start Visual Studio Code. Select File -> Open Folder... -> browse to xmc.cmake directory (on macOS, use File -> Open menu).

3. Install the required extensions:

    * [ms-vscode.cpptools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
    * [ms-vscode.cmake-tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
    * [marus25.cortex-debug](https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug)

4. Copy .vscode/settings-template-$os.json as .vscode/settings.json, adjust paths as necessary.

    * Example of Windows-specific tweaks to settings.json:

        ```json
        {
            "modustoolbox.toolsPath": "${env:HOME}/ModusToolbox/tools_2.2",
            "cortex-debug.openocdPath": "${config:modustoolbox.toolsPath}/openocd/bin/openocd",
            "cortex-debug.armToolchainPath": "${config:modustoolbox.toolsPath}/gcc/bin",
            "cmake.configureSettings": {
                "CY_TOOLS_PATHS": "${env:HOME}/ModusToolbox/tools_2.2",
                "GCC_TOOLCHAIN_PATH": "C:/Program Files (x86)/GNU Arm Embedded Toolchain/9 2020-q2-update",
                "ARM_TOOLCHAIN_PATH": "C:/Keil_v5/ARM/ARMCLANG",
                "IAR_TOOLCHAIN_PATH": "C:/Program Files (x86)/IAR Systems/Embedded Workbench 8.4/arm"
            }
        }
        ```

    * Example of macOS-specific tweaks to settings.json:

        ```json
        {
            "modustoolbox.toolsPath": "/Applications/ModusToolbox/tools_2.2",
            "cortex-debug.openocdPath": "${config:modustoolbox.toolsPath}/openocd/bin/openocd",
            "cortex-debug.armToolchainPath": "${config:modustoolbox.toolsPath}/gcc/bin",
            "cmake.configureSettings": {
                "CY_TOOLS_PATHS": "/Applications/ModusToolbox/tools_2.2",
                "GCC_TOOLCHAIN_PATH": "${env:HOME}/Applications/gcc-arm-none-eabi-9-2020-q2-update"
            }
        }
        ```

    * Example of Linux-specific tweaks to settings.json:

        ```json
        {
            "modustoolbox.toolsPath": "${env:HOME}/ModusToolbox/tools_2.2",
            "cortex-debug.openocdPath": "${config:modustoolbox.toolsPath}/openocd/bin/openocd",
            "cortex-debug.armToolchainPath": "${config:modustoolbox.toolsPath}/gcc/bin",
            "cmake.configureSettings": {
                "CY_TOOLS_PATHS": "${env:HOME}/tools_2.2",
                "GCC_TOOLCHAIN_PATH": "/opt/gcc-arm-none-eabi-9-2020-q2-update"
            }
        }
        ```

5. In VSCode menu, select View -> Command Palette -> type: "CMake: Select a Kit" -> select one of the custom kits defined in .vscode/cmake-kits.json, for example: KIT_XMC14_BOOT_001/NOOS/GCC. Never select standard kits scanned from the host OS.

6. In the Command Palette, type: "CMake: Configure", wait while the CMake project is configured.

7. Type "CMake: Build Target", and select the build target, for example: gpio-toggle_PROGRAM. Wait while the gpio-toggle application is built and programmed.

8. Switch to the Debug tab on the left Panel, select the debug configuration Launch (KitProg3).

9. Select the target ELF file, that corresponds to the CMake selected build target. For example, select "gpio-toggle.elf" in case the current CMake target is "gpio-toggle_PROGRAM".

10. The Cortex-Debug extension should start the debugging session using OpenOCD and KitProg3 CMSIS-DAP built-in debugger.

## Continuous integration

Script `ci/build-all.sh` simplifies the automated build/compile testing of this solution. By default, it builds all supported applications for all BSPs, OSes, toolchains and build configurations.

Arguments:

* -b/--bsp - Select target BSP (KIT_XMC14_BOOT_001/...)
* -o/--os - Select target OS (NOOS/FREERTOS/RTX)
* -t/--toolchain - Select toolchain (GCC/ARM/IAR)
* -c/--config - Select CMake build configuration (Debug/Release)

Each argument can be supplied multiple times.

### Examples

Build everything:

    ./ci/build-all.sh

Build everything using IAR and ARM toolchains:

    ./ci/build-all.sh -t IAR -t ARM

Build all KIT_XMC14_BOOT_001 BSP compatible applications in Debug mode:

    ./ci/build-all.sh -b KIT_XMC14_BOOT_001 -c Debug

Build all FreeRTOS enabled applications in Release mode:

    ./ci/build-all.sh -o FREERTOS -c Release

#### Azure Pipelines

Azure Pipeline is executed for each commit in master and each GitHub Pull Request:

https://dev.azure.com/vmedvid/xmc.cmake/_build?definitionId=8

The pipeline builds all applications with GCC 9.3.1 toolchain on [vmmedvid/psoc6.cmake](https://hub.docker.com/r/vmmedvid/psoc6.cmake) Docker image.
The docker image is built on top of unofficial ModusToolbox Docker image: [vmmedvid/modustoolbox](https://hub.docker.com/r/vmmedvid/modustoolbox).

## Additional tips

* It is possible to call the Ninja program directly, for example:

        ninja -C build/KIT_XMC14_BOOT_001/NOOS/GCC/Debug gpio-toggle_PROGRAM

    Often it is useful to call the ninja with additional arguments.
    For example, the below command enables verbosity and disables parallel compilation:

        cd build/KIT_XMC14_BOOT_001/NOOS/GCC/Debug
        ninja -v -j1

* When switching between toolchain versions (cmake -DGCC_TOOLCHAIN_PATH), the old toolchain version
  is sometimes cached in the CMake build directory. The most reliable way to address this is to delete
  the build directory before switching the toolchain version:

        rm -rf build/KIT_XMC14_BOOT_001/NOOS/GCC/Debug
        cmake -G Ninja -S . -B build/KIT_XMC14_BOOT_001/NOOS/GCC/Debug \
            -DTARGET=KIT_XMC14_BOOT_001 -DOS=NOOS -DTOOLCHAIN=GCC \
            -DGCC_TOOLCHAIN_PATH="C:/Program Files (x86)/GNU Arm Embedded Toolchain/9 2020-q2-update" \
            -DCMAKE_BUILD_TYPE=Debug

[ModusToolboxForWindows]: http://dlm.cypress.com.edgesuite.net/akdlm/downloadmanager/software/ModusToolbox/ModusToolbox_2.2/ModusToolbox_2.2.0.2801-windows-install.exe
[ModusToolboxForMac]: http://dlm.cypress.com.edgesuite.net/akdlm/downloadmanager/software/ModusToolbox/ModusToolbox_2.2/ModusToolbox_2.2.0.2801-macos-install.pkg
[ModusToolboxForLinux]: http://dlm.cypress.com.edgesuite.net/akdlm/downloadmanager/software/ModusToolbox/ModusToolbox_2.2/ModusToolbox_2.2.0.2801-linux-install.tar.gz
[ModusToolboxForWindows-2.2.1]: http://dlm.cypress.com.edgesuite.net/akdlm/downloadmanager/software/ModusToolbox/ModusToolbox_2.2.1/ModusToolbox_2.2.1.3335-windows-install.exe
[ModusToolboxForMac-2.2.1]: http://dlm.cypress.com.edgesuite.net/akdlm/downloadmanager/software/ModusToolbox/ModusToolbox_2.2.1/ModusToolbox_2.2.1.3335-macos-install.pkg
[ModusToolboxForLinux-2.2.1]: http://dlm.cypress.com.edgesuite.net/akdlm/downloadmanager/software/ModusToolbox/ModusToolbox_2.2.1/ModusToolbox_2.2.1.3335-linux-install.tar.gz
