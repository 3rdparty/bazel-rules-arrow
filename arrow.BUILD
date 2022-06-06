load("@rules_foreign_cc//foreign_cc:defs.bzl", "cmake")

filegroup(
    name = "all",
    srcs = glob(["**"]),
    visibility = ["//visibility:public"],
)

cmake(
    name = "arrow",
    build_data = [
        "@com_github_3rdparty_bazel_rules_arrow//:toolchain_cmake",
    ],
    deps = [
        "@com_github_gflags_gflags//:gflags",
    ],
    cache_entries = {
        # Inject our own toolchain file so that we can replace the
        # __DATE__, __TIME__, etc macro definitions with properly
        # escaped strings otherwise we'll get compiler errors, see:
        # https://github.com/bazelbuild/rules_foreign_cc/issues/239.
        "CMAKE_TOOLCHAIN_FILE": "${EXT_BUILD_ROOT}/external/com_github_3rdparty_bazel_rules_arrow/toolchain.cmake",
        "ARROW_BUILD_SHARED": "OFF",
        "ARROW_BUILD_STATIC": "ON",
        "CMAKE_BUILD_TYPE": "RelWithDebInfo",
        "ARROW_EXTRA_ERROR_CONTEXT": "ON",
        "ARROW_PLASMA": "ON",
        "ARROW_WITH_RE2": "OFF",
        "ARROW_WITH_UTF8PROC": "OFF",
        "gflags_SOURCE": "SYSTEM",
    },
    # Bazel toolchains don't use or know about 'ranlib' because the
    # modern 'ar' does what 'ranlib' did in the past (see
    # https://github.com/envoyproxy/envoy/pull/6991 for more
    # discussion). Unfortunately CMake might still generate code that
    # tries to use 'ranlib' unless you tell it not to by setting
    # 'CMAKE_RANLIB' to the empty string. For unknown reasons, that
    # doesn't appear to work with Arrow as it still tries to use
    # 'ranlib' except the empty string just causes it to fail during
    # build. The approach we take instead is to set 'CMAKE_RANLIB' to
    # '/usr/bin/true' so that any CMake generated uses will just be a
    # no-op. We have to set this via 'generate_args' instead of in
    # 'cache_entries' because rules_foreign_cc doesn't appear to
    # correctly pick up the cache entry and instead adds
    # '-DCMAKE_RANLIB=' to the command line which overrides anything
    # we might try and do in the environment or in our toolchain
    # file. By adding this as a 'generate_args' our
    # '-DCMAKE_RANLIB=/usr/bin/true' will come _after_ their
    # '-DCMAKE_RANLIB=' so it will be used correctly.
    generate_args = [
        "-GNinja",
        "-DCMAKE_RANLIB=/usr/bin/true",
    ],
    # Since we inject our own toolchain file we set this to 'False'.
    generate_crosstool_file = False,
    lib_source = ":all",
    linkopts = [
        "-ldl",
        "-lpthread",
    ],
    out_binaries = ["plasma-store-server"],
    out_static_libs = [
        "libarrow_bundled_dependencies.a",
        "libarrow.a",
        "libplasma.a",
    ],
    visibility = ["//visibility:public"],
    working_directory = "cpp",
    alwayslink = True,
)
