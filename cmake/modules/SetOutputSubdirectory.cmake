# SetOutputSubdirectory.cmake - Copyright (c) 2019 Justin Moore

# USAGE: set_output_subdirectory(
#   RUNTIME <path>
#   LIBRARY <path>
#   ARCHIVE <path>
# )
#
# Sets the output directory underneath CMAKE_XX_OUTPUT_DIRECTORY.
# Mainly used for multi-config generators, who append the current configuration to CMAKE_XX_OUTPUT_DIRECTORY. 
function(set_output_subdirectory)
    set(arguments "RUNTIME" "LIBRARY" "ARCHIVE")
    cmake_parse_arguments(SOD "" "${arguments}" "" ${ARGN})

    get_property(multi_config GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
    foreach(type "RUNTIME" "LIBRARY" "ARCHIVE")
        if (${multi_config})
            # Run through all the multi-config configurations, and setup the output subdirectory for each.
            foreach(config ${CMAKE_CONFIGURATION_TYPES})
                string(TOUPPER "${config}" config_upper)

                if (SOD_${type})
                    set(CMAKE_${type}_OUTPUT_DIRECTORY_${config_upper} "${CMAKE_${type}_OUTPUT_DIRECTORY}/${config}/${SOD_${type}}" PARENT_SCOPE)
                endif()
            endforeach()
        else()
            # Simply append to the output directories.
            if (SOD_${type})
                set(CMAKE_${type}_OUTPUT_DIRECTORY ${CMAKE_${type}_OUTPUT_DIRECTORY}/${SOD_${type}} PARENT_SCOPE)
            endif()
        endif()
    endforeach()
endfunction()