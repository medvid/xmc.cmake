#!/usr/bin/env bash

# Switch to the root directory
cd "$(dirname "${BASH_SOURCE[0]}")/.."

# Enable strict mode
set -eu

# Diagnose tool versions
set -x
cmake --version
ninja --version
set +x

#rm -rf build
summary=""
errlist=""
NL=$'\n'

NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'

function run_cmd()
{
  echo -e "${GREEN}$@${NOCOLOR}"
  if ! "$@"; then
    # add enough timeout to enable Ctrl+C cancellation
    sleep 1
    errlist+="$@${NL}"
    return 1
  fi
}

function status()
{
  echo -e "${NL}Summary:"
  echo -e "${summary}"
  if [[ -n $errlist ]]; then
    echo -e "Errors:${NL}${RED}${errlist}${RED}"
    exit 1 # Report CI fail
  fi
}

# Install status function as Ctrl+C handler
trap status EXIT

KERNEL="$($(which uname) -s)"
case "$KERNEL" in
  CYGWIN*|MINGW*|MSYS*)
    export GCC_TOOLCHAIN_PATH="$(cygpath --mixed "${GCC_TOOLCHAIN_PATH:-C:/Program Files (x86)/GNU Arm Embedded Toolchain/10 2020-q4-major}")"
    export ARM_TOOLCHAIN_PATH="$(cygpath --mixed "${ARM_TOOLCHAIN_PATH:-C:/Program Files/ARMCompiler6.13}")"
    export IAR_TOOLCHAIN_PATH="$(cygpath --mixed "${IAR_TOOLCHAIN_PATH:-C:/Program Files (x86)/IAR Systems/Embedded Workbench 8.4/arm}")"
    export LLVM_TOOLCHAIN_PATH="$(cygpath --mixed "${LLVM_TOOLCHAIN_PATH:-C:/Program Files/LLVM}")"
    default_toolchain_list="GCC ARM IAR"
    ;;
  Linux*)
    export GCC_TOOLCHAIN_PATH="${GCC_TOOLCHAIN_PATH:-/opt/gcc-arm-none-eabi-10-2020-q4-major}"
    export LLVM_TOOLCHAIN_PATH="${LLVM_TOOLCHAIN_PATH:-/usr}"
    default_toolchain_list="GCC"
    ;;
  Darwin*)
    export GCC_TOOLCHAIN_PATH="${GCC_TOOLCHAIN_PATH:-/Applications/ARM}"
    export LLVM_TOOLCHAIN_PATH="${LLVM_TOOLCHAIN_PATH:-/usr/local/opt/llvm}"
    default_toolchain_list="GCC"
    ;;
  *)
    echo >&2 "[ERROR]: unsupported OS: $KERNEL"
    exit 1
    ;;
esac

declare -a bsp_list
declare -a os_list
declare -a toolchain_list
declare -a config_list

# parse command line inputs
while (( $# > 0 )); do
  case "$1" in
    -b | --bsp)
      [[ $# -le 1 ]] && { echo "[ERROR] $1 argument requires value"; exit 1; }
      shift
      bsp_list+=("$1")
      ;;
    -o | --os)
      [[ $# -le 1 ]] && { echo "[ERROR] $1 argument requires value"; exit 1; }
      shift
      os_list+=("$1")
      ;;
    -t | --toolchain)
      [[ $# -le 1 ]] && { echo "[ERROR] $1 argument requires value"; exit 1; }
      shift
      toolchain_list+=("$1")
      ;;
    -c | --config)
      [[ $# -le 1 ]] && { echo "[ERROR] $1 argument requires value"; exit 1; }
      shift
      config_list+=("$1")
      ;;
    *)
      echo "[ERROR] Unknown parameter $1"
      exit 1
      ;;
  esac
  shift
done

# Set default values for all optional arguments
# NOTE: commented non-essential BSPs to speedup the CI pipeline
[[ -z ${bsp_list+x} ]] && bsp_list=(
  "KIT_XMC14_BOOT_001"
  "KIT_XMC47_RELAX_V1"
)
[[ -z ${os_list+x} ]] && os_list=(
  "NOOS"
  "FREERTOS"
)
[[ -z ${toolchain_list+x} ]] && toolchain_list=${default_toolchain_list}
[[ -z ${config_list+x} ]] && config_list=(
  "Debug"
  "Release"
)

echo "TARGET list: ${bsp_list[*]}"
echo "OS list: ${os_list[*]}"
echo "TOOLCHAIN list: ${toolchain_list[*]}"
echo "CMAKE_BUILD_TYPE list: ${config_list[*]}"

for bsp in "${bsp_list[@]}"; do
  for os in "${os_list[@]}"; do
    for toolchain in "${toolchain_list[@]}"; do
      for config in "${config_list[@]}"; do
        id=$bsp/$os/$toolchain/$config
        echo id=$id
        cfg_cmd="cmake -S . -B build/$id -G Ninja -DTARGET=$bsp -DOS=$os -DTOOLCHAIN=$toolchain -DCMAKE_BUILD_TYPE=$config"
        bld_cmd="cmake --build build/$id"
        if run_cmd $cfg_cmd && run_cmd $bld_cmd; then
          summary+="${GREEN}PASS: ${id}${NOCOLOR}${NL}"
        else
          summary+="${RED}FAIL: ${id}${NOCOLOR}${NL}"
        fi
      done
    done
  done
done
