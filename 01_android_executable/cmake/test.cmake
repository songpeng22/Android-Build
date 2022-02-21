CMAKE_MINIMUM_REQUIRED(VERSION 3.2 FATAL_ERROR)

macro(test LIB_NAME)
    ##
     # start to pack
    ##
    #add_custom_command(TARGET <target>
    #               PRE_BUILD | PRE_LINK | POST_BUILD
    #               COMMAND command1 [ARGS] [args1...]
    #               [COMMAND command2 [ARGS] [args2...] ...]
    #               [BYPRODUCTS [files...]]
    #               [WORKING_DIRECTORY dir]
    #               [COMMENT comment]
    #               [VERBATIM] [USES_TERMINAL]
    #               [COMMAND_EXPAND_LISTS])
    add_custom_command(
        # after the target has been created, this custom command will start to run
        TARGET ${LIB_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E echo "post build: test()......"
        #COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/${LIB_FULL_NAME} ${QT_ANDROID_APP_BINARY_DIR}/libs/${ANDROID_ABI}
       	COMMAND adb connect 172.25.115.199
        COMMAND pwd
        COMMAND adb push qtTest /data/bin
        COMMAND adb push ../libs/libc++_shared.so /data/bin
		COMMAND adb shell chmod +x /data/bin/qtTest
        COMMAND adb shell "export LD_LIBRARY_PATH=D_LIBRARY_PATH:/data/bin;/data/bin/qtTest"	
        COMMAND adb disconnect
    )
endmacro()
