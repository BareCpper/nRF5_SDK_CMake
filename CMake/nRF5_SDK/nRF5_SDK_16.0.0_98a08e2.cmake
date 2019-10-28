
add_library( nRF5_SDK INTERFACE )

target_include_directories( nRF5_SDK 
INTERFACE
	"${CMAKE_CURRENT_LIST_DIR}/config"	
	"${nRF5_SDK_ROOT}/components"
	"${nRF5_SDK_ROOT}/modules/nrfx/mdk" 
	"${nRF5_SDK_ROOT}/components/boards"
	"${nRF5_SDK_ROOT}/components/libraries/scheduler "
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
    INTERFACE 
		"${nRF5_SDK_ROOT}/components/libraries/util/app_error.c"
		"${nRF5_SDK_ROOT}/components/libraries/util/app_error_weak.c"
		"${nRF5_SDK_ROOT}/components/libraries/util/app_util_platform.c"
		"${nRF5_SDK_ROOT}/components/libraries/util/app_error_handler_gcc.c"

		#${nRF5_SDK_ROOT}/modules/nrfx/mdk/gcc_startup_nrf52840.S
		#"${nRF5_SDK_ROOT}/components/libraries/bsp/bsp.c"
		"${nRF5_SDK_ROOT}/components/boards/boards.c"
		#"${nRF5_SDK_ROOT}/components/libraries/timer/app_timer2.c"
)

add_dependencies( nRF5_SDK 
	nRF5_SDK_Get
)

target_link_libraries( nRF5_SDK 
INTERFACE
	${BOARD}
	${SOFTDEVICE}
)

set_source_files_properties(
	${nRF5_SDK_SOURCE_FILES}
		PROPERTIES GENERATED 1)