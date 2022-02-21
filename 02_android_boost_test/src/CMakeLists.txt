CMAKE_MINIMUM_REQUIRED(VERSION 3.2)
message( "****************************************break line****************************************" )
MESSAGE(STATUS "CMAKE_GENERATOR: " ${CMAKE_GENERATOR})
MESSAGE(STATUS "CMAKE_SOURCE_DIR: " ${CMAKE_SOURCE_DIR})
MESSAGE(STATUS "CMAKE_CURRENT_BINARY_DIR: " ${CMAKE_CURRENT_BINARY_DIR})


# CMake predefine
# some predefines must be placed before PROJECT() section, in order to make right decision during cmake compiler choosing 
include("../cmake/android_predefine.cmake")
MESSAGE(STATUS "QT_HOME: " ${QT_ANDROID_QT_ROOT})
MESSAGE(STATUS "NDK_HOME: " ${QT_ANDROID_NDK_ROOT})
MESSAGE(STATUS "SDK_HOME: " ${QT_ANDROID_SDK_ROOT})

#Solution name
PROJECT(Android_Solution)
#project
SET ( PROJECT_NAME qtTest )

# CMake include 
# CMake include QT
#include("../cmake/qt.cmake")
#CHOOSE_QT_SDK(QT_ANDROID)
#useQtModule(Core)
#useQtModule(Gui)
#useQtModule(Widgets)
#useQtModule(Quick)
#useQtModule(QuickWidgets)
#useQtModule(QuickControls2)
#useQtModule(Qml)
#useQtModule(Network)
# CMake include android
include(../cmake/test.cmake)


# make sure that the Android toolchain is used
IF(NOT ANDROID)
    MESSAGE(STATUS "ANDROID not exist.")
ELSE()
    MESSAGE(STATUS "ANDROID: " ${ANDROID})
ENDIF()

# CMake flags
SET(CMAKE_BUILD_TYPE Debug)
#SET(CMAKE_CXX_FLAGS_DEBUG "-std=c++11")	#/MTd
add_compile_options(-Wall)
MESSAGE(STATUS "CMAKE_C_FLAGS: " ${CMAKE_C_FLAGS})
MESSAGE(STATUS "CMAKE_CXX_FLAGS: " ${CMAKE_CXX_FLAGS})
MESSAGE(STATUS "CMAKE_C_FLAGS_DEBUG: " ${CMAKE_C_FLAGS_DEBUG})
MESSAGE(STATUS "CMAKE_CXX_FLAGS_DEBUG: " ${CMAKE_CXX_FLAGS_DEBUG})


INCLUDE_DIRECTORIES(
# Qt5::Core means there is "./include/QtCore""
    C:/Android_NDK/android-ndk-r19c/sources/cxx-stl/llvm-libc++/include
    #C:/Android_NDK/android-ndk-r19c/sources/cxx-stl/llvm-libc++abi/include
    # boost
    ../../extern/boost/arm64-v8a/include/
    #${QT_INCLUDES}
)

link_directories(
    # QT .so
    #C:/Qt/Qt5.12.4/5.12.4/android_arm64_v8a/lib/
    # libc++
    C:/Android_NDK/android-ndk-r19c/sources/cxx-stl/llvm-libc++/libs/arm64-v8a/
    # libstdc++ 
    C:/Android_NDK/android-ndk-r19c/toolchains/llvm/prebuilt/windows/sysroot/usr/lib/aarch64-linux-android/21
    #C:/Android_NDK/android-ndk-r19c/platforms/android-21/arch-arm64/usr/lib/
    # boost
    ../../extern/boost/arm64-v8a/lib/
)

#project
FILE (GLOB PROJECT_SOURCES
	*.cpp
)

SET (PROJECT_HEADERS

)

ADD_DEFINITIONS(
    #-DZMQ_STATIC
)

ADD_EXECUTABLE ( ${PROJECT_NAME} ${PROJECT_SOURCES} ${PROJECT_HEADERS} )

# Platform libs
set(PLIBS
    #liblog.so
    #libz.so
    libc++_shared.so
    libstdc++.so
    #libGLESv2.so
    #libQt5QuickTemplates2.so
    libboost_system.so
)

# Must After add_executable
target_link_libraries( ${PROJECT_NAME}
    ${PLIBS}
    #${QT_LIBS}
)

if(ANDROID)
    test( ${PROJECT_NAME} )
endif()
