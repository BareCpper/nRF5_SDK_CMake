
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