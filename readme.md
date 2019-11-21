Pre-requisites:
-----------------------
 * Install: GNU Tools ARM Embedded/8 2019-q3-update
   @todo Make GNU tools automated download/docker dependency
 * [Optional] Nordic nRF52 SDK is automatically downloaded from the Cmake, if you have it pre-installed define environment variable nRF5_SDK_ROOT={path-to-SDK}


Build and flash
-----------------------

```
mkdir build
cd build
cmake -G "Unix Makefiles" ..
cmake --build . --target flash_emteq-vr-usb
```
