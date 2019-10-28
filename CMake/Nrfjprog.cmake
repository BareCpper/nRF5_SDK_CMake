find_program(NRFJPROG
    nrfjprog)

find_program(MERGEHEX
    mergehex)

if (NRFJPROG AND MERGEHEX )
    add_custom_target(merge)
    function(add_flash_target target)
        # Both the manual <merge> and <flash> target and depends on
        # the custom command that generates the merged hexfile.
        add_custom_target(merge_${target}
            DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex)

        add_dependencies(merge merge_${target})

	#@echo Flashing: s132_nrf52_7.0.1_softdevice.hex
	#nrfjprog -f nrf52 --program $(SDK_ROOT)/components/softdevice/s132/hex/s132_nrf52_7.0.1_softdevice.hex --sectorerase
	#nrfjprog -f nrf52 --reset
			
        add_custom_target(flash_${target}
            COMMAND ${NRFJPROG} -f nrf52 --program "${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex" --sectorerase
            COMMAND ${NRFJPROG} -f nrf52 --reset
            USES_TERMINAL
            DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex)

        add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex"
            COMMAND ${MERGEHEX} -m "${${SOFTDEVICE}_HEX_FILE}" "${CMAKE_CURRENT_BINARY_DIR}/${target}.hex" -o "${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex"
            DEPENDS "${target}"
					"${${SOFTDEVICE}_HEX_FILE}"
					"${CMAKE_CURRENT_BINARY_DIR}/${target}.hex"
            VERBATIM)
			
		add_custom_command(
			TARGET merge merge_${target}
			POST_BUILD
			COMMAND arm-none-eabi-size "${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex")
    endfunction(add_flash_target)
else ()
    message(STATUS "Could not find nRFx command line tools (`nrfjprog` and `mergehex`).
   See http://infocenter.nordicsemi.com/topic/com.nordic.infocenter.tools/dita/tools/nrf5x_command_line_tools/nrf5x_installation.html?cp=5_1_1.
   Flash target will not be supported.")
    function(add_flash_target target)
        # Not supported
    endfunction(add_flash_target)
endif (NRFJPROG AND MERGEHEX)
