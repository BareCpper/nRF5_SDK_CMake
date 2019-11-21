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
					
        add_custom_target(flash_${target} ALL
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
   See https://www.nordicsemi.com/Software-and-tools/Development-Tools/nRF-Command-Line-Tools/Download
   You may still compile binary images but Flash target will not be supported.")
    function(add_flash_target target)
        # Not supported
    endfunction(add_flash_target)
endif (NRFJPROG AND MERGEHEX)
