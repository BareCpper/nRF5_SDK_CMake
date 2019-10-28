# CMakeList.txt : Top-level CMake project file, do global configuration
# and include sub-projects here.
#
# @ref https://github.com/NordicSemiconductor/nRF5-SDK-for-Mesh


cmake_minimum_required (VERSION 3.8)

set( CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_SOURCE_DIR}/CMake/toolchain/gccarmemb.cmake"  )
include("${CMAKE_TOOLCHAIN_FILE}")

project ("emteq-embedded" C CXX ASM)

set(CMAKE_CONFIG_DIR "${CMAKE_SOURCE_DIR}/CMake")

include("${CMAKE_CONFIG_DIR}/FindSDK.cmake")
include("${CMAKE_CONFIG_DIR}/Board.cmake")
include("${CMAKE_CONFIG_DIR}/Platform.cmake")
include("${CMAKE_CONFIG_DIR}/SoftDevice.cmake")


# We have to return manually from here as the CMake generation doesn't stop and we have the nRF5_SDK target available.
if ( NOT nRF5_SDK_ROOT )
	return()
endif()

include("${CMAKE_CONFIG_DIR}/platform/${PLATFORM}.cmake")
include("${CMAKE_CONFIG_DIR}/board/${BOARD}.cmake")
include("${CMAKE_CONFIG_DIR}/softdevice/${SOFTDEVICE}.cmake")
include("${CMAKE_CONFIG_DIR}/architecture/${${PLATFORM}_ARCH}.cmake")
include("${CMAKE_CONFIG_DIR}/nRF5_SDK/${nRF5_SDK_VERSION}.cmake")

message(STATUS "SDK: ${nRF5_SDK_VERSION}")
message(STATUS "Platform: ${PLATFORM}")
message(STATUS "Arch: ${${PLATFORM}_ARCH}")
message(STATUS "SoftDevice: ${SOFTDEVICE}")
message(STATUS "Board: ${BOARD}")

include("${CMAKE_CONFIG_DIR}/Nrfjprog.cmake") # @note Target flashing only


# Include sub-projects.
add_subdirectory ("emteq-vr-usb")
