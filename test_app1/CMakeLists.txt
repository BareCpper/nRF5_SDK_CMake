# Based off:${nRF5_nRF5_SDK_ROOT}\nRF5_SDK_16.0.0_98a08e2\examples\peripheral\serial\pca10056\blank\armgcc\makefile

# Add source to this project's executable.
add_executable( nrf52_Test_App1 )
add_executable(nRF52::Test::App1 ALIAS nrf52_Test_App1)

target_include_directories( nrf52_Test_App1
  PRIVATE
	${CMAKE_CURRENT_LIST_DIR} 	
)

target_sources( nrf52_Test_App1 
    PRIVATE 
        ${CMAKE_CURRENT_LIST_DIR}/main.c
)

target_link_libraries( nrf52_Test_App1 
PUBLIC
    nRF5_SDK
	#${PLATFORM}
	#${SOFTDEVICE}
	
)

target_link_options( nrf52_Test_App1 PRIVATE 
	-L${nRF5_SDK_ROOT}/modules/nrfx/mdk
	-T${CMAKE_CURRENT_LIST_DIR}/gcc_nrf52.ld
)

create_hex( nrf52_Test_App1 )
add_flash_target( nrf52_Test_App1 )

# TODO: Add tests and install targets if needed.
