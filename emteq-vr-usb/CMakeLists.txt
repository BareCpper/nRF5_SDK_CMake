
# Add source to this project's executable.
add_executable( emteq-vr-usb )
add_executable(Emteq::Vr::Firmware ALIAS emteq-vr-usb)

# Based off:${nRF5_nRF5_SDK_ROOT}\nRF5_SDK_16.0.0_98a08e2\examples\peripheral\serial\pca10056\blank\armgcc\makefile
target_include_directories( emteq-vr-usb
  PRIVATE
	${CMAKE_CURRENT_LIST_DIR} 	
)

target_sources( emteq-vr-usb 
    PRIVATE 
        ${CMAKE_CURRENT_LIST_DIR}/emteq-vr.h
        ${CMAKE_CURRENT_LIST_DIR}/emteq-vr.c
)

### @todo These should all be in a dependent library as part of nRF5_SDK or sub-module etc!!!
target_sources( emteq-vr-usb 
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

target_link_libraries( emteq-vr-usb 
PUBLIC
	${PLATFORM}
	${SOFTDEVICE}
	nRF5_SDK
)

target_link_options( emteq-vr-usb PRIVATE 
	-L${nRF5_SDK_ROOT}/modules/nrfx/mdk
	-T${CMAKE_CURRENT_LIST_DIR}/emteqvr_gcc_nrf52.ld
)

create_hex( emteq-vr-usb )
add_flash_target( emteq-vr-usb )

# TODO: Add tests and install targets if needed.

#find_program(NRFJPROG nrfjprog)
#find_program(MERGEHEX mergehex)

# --sectorerase
#add_custom_target(flash_EmteqVrFirmware
	#COMMAND  nrfjprog -f nrf52 --program ${CMAKE_CURRENT_BINARY_DIR}/EmteqVr.hex 
	#USES_TERMINAL
	#DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/EmteqVr.hex)