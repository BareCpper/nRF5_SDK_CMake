set(TOOLCHAIN_TARGET arm-none-eabi)
set(TOOLCHAIN_ROOT "C:/Program Files (x86)/GNU Tools ARM Embedded/8 2019-q3-update" CACHE STRING "Path to GNU GCC Embedded build tools")

set(CMAKE_CROSSCOMPILING TRUE )
set(CMAKE_SYSTEM_NAME "Generic")
set(CMAKE_SYSTEM_PROCESSOR "ARM")

SET(CMAKE_C_COMPILER_TARGET ${TOOLCHAIN_TARGET})
set(CMAKE_C_COMPILER ${TOOLCHAIN_TARGET}-gcc)

SET(CMAKE_ASM_COMPILER_TARGET ${TOOLCHAIN_TARGET})
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})

SET(CMAKE_CXX_COMPILER_TARGET ${TOOLCHAIN_TARGET})
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_TARGET}-g++)

set(CMAKE_TRY_COMPILE_TOOLCHAIN_TARGET_TYPE STATIC_LIBRARY)

SET(CMAKE_C_COMPILER_EXTERNAL_TOOLCHAIN ${TOOLCHAIN_ROOT})
SET(CMAKE_CXX_COMPILER_EXTERNAL_TOOLCHAIN ${TOOLCHAIN_ROOT})

set(CMAKE_OBJCOPY ${TOOLCHAIN_ROOT}/bin/${TOOLCHAIN_TARGET}-objcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE_UTIL ${TOOLCHAIN_ROOT}/bin/${TOOLCHAIN_TARGET}-size CACHE INTERNAL "size tool")

# Assembler flags common to all targets
set(all_flags "-MP -MD -O3 -g3  -D__HEAP_SIZE=8192 -D__STACK_SIZE=8192") #-O3   -Wextra
set(data_flags "-ffunction-sections -fdata-sections -fno-strict-aliasing -fno-builtin -fshort-enums")
set(warning_flags "-Wall -Werror") #-Wno-attributes -Wno-format
SET(ARCH_FLAGS "-mcpu=cortex-m4 -mthumb -mabi=aapcs -mfloat-abi=hard -mfpu=fpv4-sp-d16")

SET(CMAKE_C_FLAGS "-std=c99 ${all_flags} ${warning_flags} ${data_flags} ${ARCH_FLAGS}" CACHE STRING "Common flags for C compiler")
SET(CMAKE_ASM_FLAGS "-x assembler-with-cpp ${CMAKE_C_FLAGS}" )
SET(CMAKE_CXX_FLAGS "-std=c++14 -fno-exceptions -fno-threadsafe-statics  ${all_flags} ${warning_flags} ${data_flags} ${ARCH_FLAGS}" CACHE STRING "Common flags for C++ compiler")
SET(CMAKE_EXE_LINKER_FLAGS "-lm ${ARCH_FLAGS} -Wl,--gc-sections --specs=nano.specs --specs=nosys.specs -Wl,-Map=output.map" )

set(CMAKE_SYSROOT ${TOOLCHAIN_ROOT}/${TOOLCHAIN_TARGET})
set(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN_ROOT})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

function (create_hex executable)
    add_custom_command(
        TARGET ${executable}
        POST_BUILD
        COMMAND arm-none-eabi-objcopy -O ihex ${CMAKE_CURRENT_BINARY_DIR}/${executable} ${CMAKE_CURRENT_BINARY_DIR}/${executable}.hex
        BYPRODUCTS ${CMAKE_CURRENT_BINARY_DIR}/${executable}.hex)

    add_custom_command(
        TARGET ${executable}
        POST_BUILD
        COMMAND arm-none-eabi-size ${CMAKE_CURRENT_BINARY_DIR}/${executable})
endfunction(create_hex)


if (CMAKE_INTERPROCEDURAL_OPTIMIZATION)
    message(WARNING
        "CMAKE_INTERPROCEDURAL_OPTIMIZATION enables -flto with GCC which can lead to unexpected behavior. "
        "One particular problem is that the interrupt vector table can be messed up if the startup file "
        "isn't the first source file of the target. In general weak symbols tend to cause problems.\n"
        "More information https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83967. "
        )
endif (CMAKE_INTERPROCEDURAL_OPTIMIZATION)
