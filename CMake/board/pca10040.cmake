
add_library( pca10040 )

target_include_directories( pca10040 
	PUBLIC 
		"${SDK_ROOT}/components/boards"
)

target_compile_definitions(pca10040
	PUBLIC
		BOARD_PCA10040
		CONFIG_GPIO_AS_PINRESET
		BSP_DEFINES_ONLY # @todo What?
)

target_sources( pca10040
    PRIVATE 
		"${nRF5_SDK_ROOT}/modules/nrfx/mdk/system_nrf52.c"
)

target_link_libraries( pca10040 
PUBLIC
	${PLATFORM} 
)

get_target_property(pca10040_SOURCE_FILES pca10040 SOURCES)
set_source_files_properties( ${pca10040_SOURCE_FILES} PROPERTIES GENERATED 1)