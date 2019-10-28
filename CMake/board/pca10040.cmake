
add_library( pca10040 INTERFACE )

target_include_directories( pca10040 
INTERFACE
    "${SDK_ROOT}/components/boards"
)

target_compile_definitions(pca10040
	INTERFACE
		BOARD_PCA10040
		CONFIG_GPIO_AS_PINRESET
		BSP_DEFINES_ONLY # @todo What?
)

target_link_libraries( pca10040 
INTERFACE
	${PLATFORM} 
)
