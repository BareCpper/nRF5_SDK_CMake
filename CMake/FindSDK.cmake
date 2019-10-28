set(nRF5_SDK_VERSION "nRF5_SDK_16.0.0_98a08e2" CACHE STRING "nRF5 SDK version")

if (NOT nRF5_SDK_VERSION)
	message(FATAL_ERROR "You need to specifiy a nRF5_SDK_VERSION to use.")
endif()

set(nRF5_SDK_DEFAULTROOT "${CMAKE_SOURCE_DIR}/../${nRF5_SDK_VERSION}/" )

# Check for user-defined SDK path
if (nRF5_SDK_ROOT AND EXISTS "${nRF5_SDK_ROOT}/license.txt")
	set(nRF5_SDK_ROOT "${nRF5_SDK_ROOT}" CACHE STRING "nRF5 SDK version" )
	add_custom_target(nRF5_SDK_Get) # We have the SDK already so make a dummy dependency

#Check for default-download SDK path
elseif (EXISTS "${nRF5_SDK_DEFAULTROOT}/license.txt")
	set(nRF5_SDK_ROOT "${nRF5_SDK_DEFAULTROOT}" CACHE STRING "nRF5 SDK version" )
	add_custom_target(nRF5_SDK_Get) # We have the SDK already so make a dummy dependency

else() # Download SDK
	if ( NOT nRF5_SDK_ROOT )
		set(nRF5_SDK_ROOT     "${nRF5_SDK_DEFAULTROOT}")
	endif()

	string(REGEX REPLACE "(nRF5)([1]?_SDK_)([0-9]*).*" "\\1\\2v\\3.x.x" SDK_DIR ${nRF5_SDK_VERSION})
	set(nRF5_SDK_URL "https://developer.nordicsemi.com/nRF5_SDK/${SDK_DIR}/${nRF5_SDK_VERSION}.zip")
	set(nRF5_SDK_TMPDIR  "${CMAKE_CURRENT_BINARY_DIR}/${nRF5_SDK_VERSION}/" )
	set(nRF5_SDK_ZIPDIR  "${nRF5_SDK_ROOT}/zip/" )
	set(nRF5_SDK_ZIPNAME  "${nRF5_SDK_VERSION}.zip" )
	set(nRF5_SDK_ZIPPATH  "${nRF5_SDK_ZIPDIR}${nRF5_SDK_ZIPNAME}" )

	include(ExternalProject)
	ExternalProject_Add(nRF5_SDK_Get
		PREFIX "${nRF5_SDK_VERSION}"
		TMP_DIR "${nRF5_SDK_TMPDIR}"
		SOURCE_DIR "${nRF5_SDK_ROOT}"
		DOWNLOAD_DIR "${nRF5_SDK_ZIPDIR}"
		DOWNLOAD_NAME "${nRF5_SDK_ZIPNAME}"
		URL "${nRF5_SDK_URL}"
		URL_HASH SHA1=E73FCC22476BB57AF36CFAF745CA8562747FDF93
		# PATCH_COMMAND ${PATCH_COMMAND}
		# No build or configure commands
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
		INSTALL_COMMAND ""
		#LOG_DOWNLOAD ON
		EXCLUDE_FROM_ALL ON)
endif()
