"""Dependency specific initialization."""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")

def deps(repo_mapping = {}):
    rules_foreign_cc_dependencies()

    maybe(
        new_git_repository,
        name = "com_github_apache_arrow",
        remote = "https://github.com/apache/arrow",
        commit = "e90472e35b40f58b17d408438bb8de1641bfe6ef",
        shallow_since = "1643414904 +0100",
        build_file = "@com_github_3rdparty_bazel_rules_arrow//:arrow.BUILD",
        repo_mapping = repo_mapping,
    )
