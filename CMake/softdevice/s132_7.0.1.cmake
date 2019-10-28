

set(softdevice_NAME "s132")
set(softdevice_MAJORVERSION "7")
set(softdevice_VERSION "${softdevice_MAJORVERSION}.0.1")

set(softdevice_ID "${softdevice_NAME}_${softdevice_VERSION}")

set(softdevice_ROOT "${nRF5_SDK_ROOT}/components/softdevice/${softdevice_NAME}")

add_library( ${softdevice_ID} INTERFACE )

set(${softdevice_ID}_VERSION "${softdevice_VERSION}")

set(${softdevice_ID}_MAJOR_VERSION "${softdevice_MAJORVERSION}")


target_include_directories( ${softdevice_ID} 
	INTERFACE
		"${softdevice_ROOT}/headers"
		"${softdevice_ROOT}/headers/nrf52"
)

set(${softdevice_ID}_HEX_FILE
    "${softdevice_ROOT}/hex/${softdevice_NAME}_nrf52_${softdevice_VERSION}_softdevice.hex")


string(TOUPPER ${softdevice_NAME} softdevice_NAMEDEFINE)

target_compile_definitions( ${softdevice_ID}
	INTERFACE
		${softdevice_NAMEDEFINE}
		SOFTDEVICE_PRESENT
		NRF_SD_BLE_API_VERSION=${${softdevice_ID}_MAJOR_VERSION}
)	

target_link_libraries( ${softdevice_ID} 
INTERFACE
	${BOARD} 
)

#REF:@ ASMFLAGS += -DNRF_SD_BLE_API_VERSION=7
#		S132 # Soft device
#REF:@ ASMFLAGS += -DS132
#REF:@ ASMFLAGS += -DSOFTDEVICE_PRESENT