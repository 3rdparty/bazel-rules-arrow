![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

## For now we only support Linux and the support for Windows and macOS might be added in the future.

# bazel-rules-arrow

## Bazel build rules for [apache/arrow](https://github.com/apache/arrow)

Follows a "repos/deps" pattern (in order to help with recursive dependencies). To use:

1. Copy `bazel/repos.bzl` into your repository at `3rdparty/bazel-rules-arrow/repos.bzl` and add an empty `BUILD` (or `BUILD.bazel`) to `3rdparty/bazel-rules-arrow` as well.

2. Copy all of the directories from `3rdparty` that you ***don't*** already have in ***your*** repository's `3rdparty` directory.

3. Add the following to your `WORKSPACE` (or `WORKSPACE.bazel`):

```bazel
load("//3rdparty/bazel-rules-arrow:repos.bzl", arrow_repos="repos")
arrow_repos()
load("@com_github_3rdparty_bazel_rules_arrow//bazel:deps.bzl", arrow_deps="deps")
arrow_deps()
```

Or ... to simplify others depending on ***your*** repository, add the following to your `repos.bzl`:

```bazel
load("//3rdparty/bazel-rules-arrow:repos.bzl", arrow_repos="repos")
def repos():
    arrow_repos()
```

And the following to your `deps.bzl`:

```bazel
load("@com_github_3rdparty_bazel_rules_arrow//bazel:deps.bzl", arrow_deps="deps")
def deps():
    arrow_deps()
```

4. You can then use `@com_github_apache_arrow//:expected` in your target's `deps`.
