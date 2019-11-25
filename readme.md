# Install build-tools
-----------------------

* CMake
    - Download and install CMake https://cmake.org/download/#latest (version 3.13 of above)
    - Use the binary installer,
    - Recommend add 'CMake to the system path' for all users.

* Ninja
    - Download and install Ninja https://github.com/ninja-build/ninja/releases/latest
    - You’ll need to add it to the system 'PATH' environment path manually to point to the directory you extract it to. 

* Make
    - Download and install GNU Make tools (Windows download http://gnuwin32.sourceforge.net/packages/make.htm)
    - You’ll need to add it to the system 'PATH' environment path manually to add "C:\Program Files (x86)\GnuWin32\bin" on windows
   
# Install platform-tools
-----------------------

* GNU Tools for ARM Embedded Processors
    - Download compiler tools for ARM https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
(e.g. Windows users download 'gcc-arm-none-eabi-9-2019-q4-major-win32.exe')
    - Install as defaults but we recommend you check option to 'Add path to environment variable'
 
 ~@todo Make GNU tools automated download/docker dependency~
    
 * Nordic nRF52 SDK is automatically downloaded from the Cmake, if you have it pre-installed define environment variable nRF5_SDK_ROOT={path-to-SDK}
 
 
# Install programming-tools

## Serial DFU
* SiLabs CP2104 driver
    - Download driver http://www.silabs.com/products/mcu/pages/usbtouartbridgevcpdrivers.aspx is required for USB to Serial when using with Feather nRF52832
    
* nrfutil Firmware Update Tools
    - Windows prebuilt executable here https://github.com/NordicSemiconductor/pc-nrfutil/releases/tag/v5.2.0 add this to your path environment (e.g. Copy into to C:\Program Files\Nordic Semiconductor\nrf-command-line-tools\bin)
    - Python setup procedure documented https://github.com/NordicSemiconductor/pc-nrfutil#installing-from-pypi (Link to installing PIP is in chapter below)
 
* [ WIP ] Adafruit https://github.com/adafruit/Adafruit_nRF52_nrfutil/releases

## JTag FLash
* nRF Command Line Tools ('nrfjprog' and 'mergehex')
    - https://www.nordicsemi.com/Software-and-tools/Development-Tools/nRF-Command-Line-Tools/Download
    - Required if you wish to flash firmware, you may compile firmware withtout installing these tools.
    - Recommend choosing '64bit' platform version from list on left. 
    
# Build

## Powershell: 

```
mkdir -p build
cd build
cmake -G Ninja ..
cmake --build . --target flash_nrf52_Test_App1
```

# Program
## JTag Flash
Each executable shall have an associated target 'flash_*' 

## DFU
@todo Make CMake target
Example flashing BOTH SoftDevice+Application command to package and flash the 'merge' binary
```
cmake --build . -t merge
nrfutil pkg generate --hw-version 52 --sd-req 0x80 --application-version 4 --application test_app1/test_app1_merged.hex dfu_test.zip
nrfutil dfu serial -pkg dfu_test.zip -p COM3
```
... Or Adafruit tool:
```
cmake --build . -t merge
adafruit-nrfutil dfu genpkg --dev-type 0x0052 --application test_app1/test_app1_merged.hex dfu_test.zip
adafruit-nrfutil dfu serial --package dfu_test.zip -p COM3 -b 115200
```


# nRF52 CMake Library Tree
```
    Application
       |  |
nRF5_SDK   SOFTDEVICE(s132_7.0.1)
    |        |  
  BOARD(pca10040) 
         |
PLATFORM(nrf52832_xxAA) 
         |
  ARCH(cortex-m4f)
```

# Troubleshooting

## Undefined reference to `SystemInit'
* During link of application i.e nrf52_Test_App1
* gcc_startup_nrf52.S ASM file references function called 'SystemInit' which is not part of the build
```
$GNU Tools/.../bin/../lib/gcc/arm-none-eabi/9.2.1/../../../../arm-none-eabi/bin/ld.exe: ../libnrf52832_xxAA.a(gcc_startup_nrf52.S.obj): in function `Reset_Handler':
$nRF5_SDK_16.0.0_98a08e2/modules/nrfx/mdk/gcc_startup_nrf52.S:272: undefined reference to `SystemInit'
```
### Problem
PLATFORM (e.g. nrf52832_xxAA) links in gcc_startup_nrf52.S for startup sequence but depends on the 'SystemInit' function that is defined  system_nrf52.c by the BOARD (e.g. pca10040)

### Solution
PLATFORM shall supply gcc_startup_nrf52.S as PUBLIC for linkage further up the dependency chain.