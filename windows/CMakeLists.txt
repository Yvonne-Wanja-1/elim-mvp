# Project-level configuration.
cmake_minimum_required(VERSION 3.14)
project(elim_mvp LANGUAGES CXX)

# The name of the executable created for the application. Change this to change
# the on-disk name of your application.
set(BINARY_NAME "elim_mvp")

# Explicitly opt in to modern CMake behaviors to avoid warnings with recent
# versions of CMake.
cmake_policy(VERSION 3.14...3.25)

# Define build configuration option.
get_property(IS_MULTICONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(IS_MULTICONFIG)
  set(CMAKE_CONFIGURATION_TYPES "Debug;Profile;Release"
    CACHE STRING "" FORCE)
else()
  if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE "Debug" CACHE
      STRING "Flutter build mode" FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
      "Debug" "Profile" "Release")
  endif()
endif()

# Define settings for the Profile build mode.
set(CMAKE_EXE_LINKER_FLAGS_PROFILE "${CMAKE_EXE_LINKER_FLAGS_RELEASE}")
set(CMAKE_SHARED_LINKER_FLAGS_PROFILE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE}")
set(CMAKE_C_FLAGS_PROFILE "${CMAKE_C_FLAGS_RELEASE}")
set(CMAKE_CXX_FLAGS_PROFILE "${CMAKE_CXX_FLAGS_RELEASE}")

# Use Unicode for all projects.
add_definitions(-DUNICODE -D_UNICODE)

# Compilation settings that should be applied to most targets.
function(APPLY_STANDARD_SETTINGS TARGET)
  target_compile_features(${TARGET} PUBLIC cxx_std_17)
  target_compile_options(${TARGET} PRIVATE /W3 /wd"4100" /wd"4996")
  target_compile_options(${TARGET} PRIVATE /EHsc)
  target_compile_definitions(${TARGET} PRIVATE "_HAS_EXCEPTIONS=0")
  target_compile_definitions(${TARGET} PRIVATE "$<$<CONFIG:Debug>:_DEBUG>")
  target_compile_definitions(${TARGET} PRIVATE _CRT_SECURE_NO_WARNINGS)
endfunction()

# ==== Firebase SDK Setup ====
set(FIREBASE_CPP_SDK_DIR "${CMAKE_CURRENT_SOURCE_DIR}/firebase_cpp_sdk")

# First check if Firebase SDK exists in the project directory
if(NOT EXISTS "${FIREBASE_CPP_SDK_DIR}/CMakeLists.txt")
    # Try to find it in the build directory
    set(FIREBASE_CPP_SDK_DIR "${CMAKE_CURRENT_BINARY_DIR}/firebase_cpp_sdk")
    if(NOT EXISTS "${FIREBASE_CPP_SDK_DIR}/CMakeLists.txt")
        message(WARNING "Firebase C++ SDK not found. Please extract it to: ${CMAKE_CURRENT_SOURCE_DIR}/firebase_cpp_sdk")
    endif()
endif()

if(EXISTS "${FIREBASE_CPP_SDK_DIR}/CMakeLists.txt")
    message(STATUS "Found Firebase SDK at: ${FIREBASE_CPP_SDK_DIR}")
    set(FIREBASE_SDK_ROOT_DIR "${FIREBASE_CPP_SDK_DIR}")
    add_subdirectory("${FIREBASE_CPP_SDK_DIR}" "${CMAKE_CURRENT_BINARY_DIR}/firebase_build")
    include_directories("${FIREBASE_CPP_SDK_DIR}/include")
endif()

# Flutter library and tool build rules.
set(FLUTTER_MANAGED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/flutter")
add_subdirectory(${FLUTTER_MANAGED_DIR})

# Application build; see runner/CMakeLists.txt.
add_subdirectory("runner")

# Generated plugin build rules
include(flutter/generated_plugins.cmake)

# === Installation Setup ===
set(BUILD_BUNDLE_DIR "$<TARGET_FILE_DIR:${BINARY_NAME}>")
set(CMAKE_VS_INCLUDE_INSTALL_TO_DEFAULT_BUILD 1)
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "${BUILD_BUNDLE_DIR}" CACHE PATH "..." FORCE)
endif()

set(INSTALL_BUNDLE_DATA_DIR "${CMAKE_INSTALL_PREFIX}/data")
set(INSTALL_BUNDLE_LIB_DIR "${CMAKE_INSTALL_PREFIX}")

install(TARGETS ${BINARY_NAME} RUNTIME DESTINATION "${CMAKE_INSTALL_PREFIX}"
  COMPONENT Runtime)

install(FILES "${FLUTTER_ICU_DATA_FILE}" DESTINATION "${INSTALL_BUNDLE_DATA_DIR}"
  COMPONENT Runtime)

install(FILES "${FLUTTER_LIBRARY}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
  COMPONENT Runtime)

if(PLUGIN_BUNDLED_LIBRARIES)
  install(FILES "${PLUGIN_BUNDLED_LIBRARIES}"
    DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
    COMPONENT Runtime)
endif()

set(NATIVE_ASSETS_DIR "${PROJECT_BUILD_DIR}native_assets/windows/")
install(DIRECTORY "${NATIVE_ASSETS_DIR}"
   DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
   COMPONENT Runtime)

set(FLUTTER_ASSET_DIR_NAME "flutter_assets")
install(CODE "
  file(REMOVE_RECURSE \"${INSTALL_BUNDLE_DATA_DIR}/${FLUTTER_ASSET_DIR_NAME}\")
  " COMPONENT Runtime)
install(DIRECTORY "${PROJECT_BUILD_DIR}/${FLUTTER_ASSET_DIR_NAME}"
  DESTINATION "${INSTALL_BUNDLE_DATA_DIR}" COMPONENT Runtime)

install(FILES "${AOT_LIBRARY}" DESTINATION "${INSTALL_BUNDLE_DATA_DIR}"
  CONFIGURATIONS Profile;Release
  COMPONENT Runtime)

# === Firebase Link Libraries ===
if(EXISTS "${FIREBASE_CPP_SDK_DIR}/CMakeLists.txt")
    # Core Firebase libraries
    set(FIREBASE_LIBRARIES 
        firebase_app
        firebase_auth
    )

    # Link Firebase libraries
    target_link_libraries(${BINARY_NAME} PRIVATE ${FIREBASE_LIBRARIES})
    
    # Define the possible locations of the DLLs
    set(FIREBASE_DLL_DIRS
        "${FIREBASE_CPP_SDK_DIR}/libs/windows/VS2022/MD/x64"
        "${FIREBASE_CPP_SDK_DIR}/libs/windows/VS2019/MD/x64"
        "${FIREBASE_CPP_SDK_DIR}/libs/windows/x64/Debug"
    )

    # Find and copy DLLs
    foreach(DLL_DIR ${FIREBASE_DLL_DIRS})
        if(EXISTS "${DLL_DIR}")
            foreach(LIB ${FIREBASE_LIBRARIES})
                if(EXISTS "${DLL_DIR}/${LIB}.dll")
                    add_custom_command(TARGET ${BINARY_NAME} POST_BUILD
                        COMMAND ${CMAKE_COMMAND} -E copy_if_different
                        "${DLL_DIR}/${LIB}.dll"
                        $<TARGET_FILE_DIR:${BINARY_NAME}>
                    )
                endif()
            endforeach()
        endif()
    endforeach()
endif()
