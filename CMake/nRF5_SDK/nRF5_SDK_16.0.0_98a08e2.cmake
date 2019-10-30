
add_library( nRF5_SDK )

target_include_directories( nRF5_SDK 
	PUBLIC
		"${CMAKE_CURRENT_LIST_DIR}/config"	
		"${nRF5_SDK_ROOT}/components"
		"${nRF5_SDK_ROOT}/modules/nrfx/mdk" 
		"${nRF5_SDK_ROOT}/components/boards"
		"${nRF5_SDK_ROOT}/components/libraries/scheduler"
		"${nRF5_SDK_ROOT}/components/libraries/queue"
		"${nRF5_SDK_ROOT}/components/libraries/timer"
		"${nRF5_SDK_ROOT}/components/libraries/strerror"
		"${nRF5_SDK_ROOT}/components/libraries/serial"
		"${nRF5_SDK_ROOT}/components/toolchain/cmsis/include"
		"${nRF5_SDK_ROOT}/components/libraries/util"
		"${nRF5_SDK_ROOT}/components/libraries/bsp"
		"${nRF5_SDK_ROOT}/components/libraries/delay"
		"${nRF5_SDK_ROOT}/components/libraries/balloc"
		"${nRF5_SDK_ROOT}/components/libraries/ringbuf"
		"${nRF5_SDK_ROOT}/components/libraries/hardfault/nrf52"
		"${nRF5_SDK_ROOT}/components/libraries/hardfault"
		"${nRF5_SDK_ROOT}/components/libraries/log"
		"${nRF5_SDK_ROOT}/components/libraries/log/src"
		"${nRF5_SDK_ROOT}/components/libraries/button"
		"${nRF5_SDK_ROOT}/components/libraries/experimental_section_vars"
		"${nRF5_SDK_ROOT}/components/libraries/mutex"
		"${nRF5_SDK_ROOT}/components/libraries/delay"
		"${nRF5_SDK_ROOT}/components/libraries/atomic_fifo"
		"${nRF5_SDK_ROOT}/components/libraries/atomic"
		"${nRF5_SDK_ROOT}/components/libraries/sortlist"
		"${nRF5_SDK_ROOT}/components/libraries/memobj"
		"${nRF5_SDK_ROOT}/integration/nrfx"
		"${nRF5_SDK_ROOT}/integration/nrfx/legacy"
		"${nRF5_SDK_ROOT}/external/fprintf"
		"${nRF5_SDK_ROOT}/modules/nrfx"
		"${nRF5_SDK_ROOT}/modules/nrfx/hal"
		"${nRF5_SDK_ROOT}/modules/nrfx/drivers/include"
)

target_sources( nRF5_SDK
    PRIVATE 
		"${nRF5_SDK_ROOT}/components/libraries/util/app_error.c"
		"${nRF5_SDK_ROOT}/components/libraries/util/app_error_weak.c"
		"${nRF5_SDK_ROOT}/components/libraries/util/app_util_platform.c"
		"${nRF5_SDK_ROOT}/components/libraries/util/app_error_handler_gcc.c"
		"${nRF5_SDK_ROOT}/components/boards/boards.c"
)


### @todo These should all be in a dependent library as part of nRF5_SDK or sub-module etc!!!
target_sources( nRF5_SDK
    PRIVATE 
  ${nRF5_SDK_ROOT}/components/libraries/log/src/nrf_log_frontend.c 
  ${nRF5_SDK_ROOT}/components/libraries/log/src/nrf_log_str_formatter.c   
  ${nRF5_SDK_ROOT}/components/libraries/util/nrf_assert.c 
  ${nRF5_SDK_ROOT}/components/libraries/atomic/nrf_atomic.c 
  ${nRF5_SDK_ROOT}/components/libraries/balloc/nrf_balloc.c 
  ${nRF5_SDK_ROOT}/external/fprintf/nrf_fprintf.c 
  ${nRF5_SDK_ROOT}/external/fprintf/nrf_fprintf_format.c
  ${nRF5_SDK_ROOT}/components/libraries/memobj/nrf_memobj.c
  ${nRF5_SDK_ROOT}/components/libraries/ringbuf/nrf_ringbuf.c
  ${nRF5_SDK_ROOT}/components/libraries/experimental_section_vars/nrf_section_iter.c
  ${nRF5_SDK_ROOT}/components/libraries/strerror/nrf_strerror.c
  ${nRF5_SDK_ROOT}/modules/nrfx/soc/nrfx_atomic.c
  ${nRF5_SDK_ROOT}/components/softdevice/common/nrf_sdh.c
  ${nRF5_SDK_ROOT}/components/softdevice/common/nrf_sdh_soc.c
  )


add_dependencies( nRF5_SDK 
	nRF5_SDK_Get
)

target_link_libraries( nRF5_SDK 
PUBLIC
	${SOFTDEVICE}
	${BOARD}
)

get_target_property(nRF5_SDK_SOURCE_FILES nRF5_SDK SOURCES)
set_source_files_properties( ${nRF5_SDK_SOURCE_FILES} PROPERTIES GENERATED 1)