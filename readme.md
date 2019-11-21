# Install build-tools
-----------------------

* CMake
    - Download and install CMake https://cmake.org/download/#latest (version 3.13 of above)
    - Use the binary installer,
    - Recommend add 'CMake to the system path' for all users.

* Ninja
    - Download and install Ninja https://github.com/ninja-build/ninja/releases/latest
    - You’ll need to add it to the system path manually. 

   
# Install platform-tools
-----------------------
* [Optional] nRF Command Line Tools ('nrfjprog' and 'mergehex')
    - https://www.nordicsemi.com/Software-and-tools/Development-Tools/nRF-Command-Line-Tools/Download
    - Required if you wish to flash firmware, you may compile firmware withtout installing these tools.
    - Recommend choosing '64bit' platform version from list on left. 

* GNU Tools for ARM Embedded Processors
    - Download compiler tools for ARM https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
(e.g. Windows users download 'gcc-arm-none-eabi-9-2019-q4-major-win32.exe')
    - Install as defaults but we recommend you check option to **'Add path to environment variable'**
 
 ~@todo Make GNU tools automated download/docker dependency~
    
 * Nordic nRF52 SDK is automatically downloaded from the Cmake, if you have it pre-installed define environment variable nRF5_SDK_ROOT={path-to-SDK}
 
 
# Build
-----------------------

## Powershell: 

```
mkdir -p build
cd build
cmake -G Ninja ..
cmake --build . --target flash_nrf52_Test_App1
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
               