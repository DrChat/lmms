
macro(CHECK_CXX_PREPROCESSOR VAR DIRECTIVE)
	string(RANDOM UNDEFINED_KEY)

	set(TMP_FILENAME "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CxxTmp/src.cpp")
	SET(SRC "
		#if !${DIRECTIVE}
		#error ${UNDEFINED_KEY}
		#endif

		int main() { return 0; }
		")
	file(WRITE ${TMP_FILENAME} "${SRC}")

	if (NOT CMAKE_REQUIRED_QUIET)
		message(STATUS "Performing Test ${DIRECTIVE}")
	endif()
	try_compile(${VAR}
		${CMAKE_BINARY_DIR}
		${TMP_FILENAME}
		OUTPUT_VARIABLE OUTPUT_VAR
	)

	if (${VAR})
		if (NOT CMAKE_REQUIRED_QUIET)
			message(STATUS "Performing Test ${DIRECTIVE} - Success")
		endif()
	else()
		if (NOT CMAKE_REQUIRED_QUIET)
			message(STATUS "Performing Test ${DIRECTIVE} - Failed")
		endif()
	endif()
endmacro()


macro(CHECK_CXX_DEFINE VAR DEFINE)
	CHECK_CXX_PREPROCESSOR(${VAR} "defined(${DEFINE})")
endmacro()
