
add_library(nrf52832_xxAA )

set(nrf52832_xxAA_ARCH "cortex-m4f")
set(nrf52832_xxAA_FAMILY "NRF52")


target_include_directories( nrf52832_xxAA 
	PUBLIC
		"${nRF5_SDK_ROOT}/modules/nrfx"
		"${nRF5_SDK_ROOT}/modules/nrfx/mdk"
		"${nRF5_SDK_ROOT}/modules/nrfx/hal"
		"${nRF5_SDK_ROOT}/components/toolchain/cmsis/include"
)

#if (TOOLCHAIN MATCHES "gcc" OR TOOLCHAIN STREQUAL "clang")
	target_sources( nrf52832_xxAA
		PUBLIC 
		 "${nRF5_SDK_ROOT}/modules/nrfx/mdk/gcc_startup_nrf52.S" # gcc_startup_nrf52.S must be PUBLIC as depends on the 'SystemInit' specified by BOARD (i.e. system_nrf52.c)
	)
	target_include_directories( nrf52832_xxAA 
		PRIVATE
			"${nRF5_SDK_ROOT}/components/toolchain/gcc"
			"${nRF5_SDK_ROOT}/components/toolchain/cmsis/dsp/GCC"
	)
#endif()

target_link_libraries( nrf52832_xxAA 
	PUBLIC
		${nrf52832_xxAA_ARCH}
)

target_compile_definitions(nrf52832_xxAA
	PUBLIC
		NRF52
		NRF52_PAN_74
		NRF52832_XXAA
		FLOAT_ABI_HARD
)

get_target_property(nrf52832_xxAA_SOURCE_FILES nrf52832_xxAA SOURCES)
set_source_files_properties( ${nrf52832_xxAA_SOURCE_FILES} PROPERTIES GENERATED 1)

