if (DEFINED ENV{ASMFLAGS})
    string(REPLACE \\\"redacted\\\" "redacted" CMAKE_ASM_FLAGS_INIT $ENV{ASMFLAGS})
    unset(ENV{ASMFLAGS})
endif()

if (DEFINED ENV{CXXFLAGS})
    string(REPLACE \\\"redacted\\\" "redacted" CMAKE_CXX_FLAGS_INIT $ENV{CXXFLAGS})
    unset(ENV{CXXFLAGS})
endif()

if (DEFINED ENV{CFLAGS})
    string(REPLACE \\\"redacted\\\" "redacted" CMAKE_C_FLAGS_INIT $ENV{CFLAGS})
    unset(ENV{CFLAGS})
endif()
