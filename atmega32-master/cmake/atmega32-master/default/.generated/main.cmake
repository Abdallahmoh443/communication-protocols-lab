include("${CMAKE_CURRENT_LIST_DIR}/rule.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/file.cmake")

set(atmega32_master_default_library_list )

# Handle files with suffix (s|as|asm|AS|ASM|As|aS|Asm), for group default-XC8
if(atmega32_master_default_default_XC8_FILE_TYPE_assemble)
add_library(atmega32_master_default_default_XC8_assemble OBJECT ${atmega32_master_default_default_XC8_FILE_TYPE_assemble})
    atmega32_master_default_default_XC8_assemble_rule(atmega32_master_default_default_XC8_assemble)
    list(APPEND atmega32_master_default_library_list "$<TARGET_OBJECTS:atmega32_master_default_default_XC8_assemble>")

endif()

# Handle files with suffix S, for group default-XC8
if(atmega32_master_default_default_XC8_FILE_TYPE_assemblePreprocess)
add_library(atmega32_master_default_default_XC8_assemblePreprocess OBJECT ${atmega32_master_default_default_XC8_FILE_TYPE_assemblePreprocess})
    atmega32_master_default_default_XC8_assemblePreprocess_rule(atmega32_master_default_default_XC8_assemblePreprocess)
    list(APPEND atmega32_master_default_library_list "$<TARGET_OBJECTS:atmega32_master_default_default_XC8_assemblePreprocess>")

endif()

# Handle files with suffix [cC], for group default-XC8
if(atmega32_master_default_default_XC8_FILE_TYPE_compile)
add_library(atmega32_master_default_default_XC8_compile OBJECT ${atmega32_master_default_default_XC8_FILE_TYPE_compile})
    atmega32_master_default_default_XC8_compile_rule(atmega32_master_default_default_XC8_compile)
    list(APPEND atmega32_master_default_library_list "$<TARGET_OBJECTS:atmega32_master_default_default_XC8_compile>")

endif()

# Handle files with suffix elf, for group default-XC8
if(atmega32_master_default_default_XC8_FILE_TYPE_objcopy_avr)
add_library(atmega32_master_default_default_XC8_objcopy_avr OBJECT ${atmega32_master_default_default_XC8_FILE_TYPE_objcopy_avr})
    atmega32_master_default_default_XC8_objcopy_avr_rule(atmega32_master_default_default_XC8_objcopy_avr)
    list(APPEND atmega32_master_default_library_list "$<TARGET_OBJECTS:atmega32_master_default_default_XC8_objcopy_avr>")

endif()

# Handle files with suffix elf, for group default-XC8
if(atmega32_master_default_default_XC8_FILE_TYPE_objcopy_lss)
add_library(atmega32_master_default_default_XC8_objcopy_lss OBJECT ${atmega32_master_default_default_XC8_FILE_TYPE_objcopy_lss})
    atmega32_master_default_default_XC8_objcopy_lss_rule(atmega32_master_default_default_XC8_objcopy_lss)
    list(APPEND atmega32_master_default_library_list "$<TARGET_OBJECTS:atmega32_master_default_default_XC8_objcopy_lss>")

endif()


# Main target for this project
add_executable(atmega32_master_default_image_hL_t2ddL ${atmega32_master_default_library_list})

set_target_properties(atmega32_master_default_image_hL_t2ddL PROPERTIES
    OUTPUT_NAME "default"
    SUFFIX ".elf"
    ADDITIONAL_CLEAN_FILES "${output_extensions}"
    RUNTIME_OUTPUT_DIRECTORY "${atmega32_master_default_output_dir}")
target_link_libraries(atmega32_master_default_image_hL_t2ddL PRIVATE ${atmega32_master_default_default_XC8_FILE_TYPE_link})
# Add the link options from the rule file.
atmega32_master_default_link_rule( atmega32_master_default_image_hL_t2ddL)


#Add objcopy steps
atmega32_master_default_objcopy_avr_rule(atmega32_master_default_image_hL_t2ddL)
atmega32_master_default_objcopy_lss_rule(atmega32_master_default_image_hL_t2ddL)

