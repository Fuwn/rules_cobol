<h1 align="center"><code>rules_cobol</code></h1>

<p align="center"><b>COBOL build rules for Bazel</b></p>

`rules_cobol` is a set of Bazel build rules to make working with COBOL in Bazel
possible.

## Usage

### `WORKSPACE`

First, grab the latest version of `rules_cobol` and set it up in your
`WORKSPACE`.

```python
# Load `http_archive`
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Preferably, the latest version of `rules_cobol`
RULES_COBOL_VERSION = "0.1.0"

# Download `rules_cobol`
http_archive(
    name = "io_bazel_rules_cobol",
    sha256 = "fcbc86d25e9fa38c86c9b2a34e914d2553c659f3b9b52796560aefb2423af56a",
    strip_prefix = "rules_cobol-{v}".format(v = RULES_COBOL_VERSION),
    urls = [
        "https://github.com/Fuwn/rules_cobol/archive/refs/tags/{v}.zip".format(v = RULES_COBOL_VERSION),
    ],
)

# Load `cobol_rules_dependencies` from `rules_cobol`
load("@io_bazel_rules_cobol//cobol:deps.bzl", "cobol_rules_dependencies")

# Grab `rules_cobol`s dependencies
cobol_rules_dependencies()
```

### `BUILD`

Next, create a target using the `cobol_binary` rule in your `BUILD` file.

```python
# Load `cobol_binary` from `rules_cobol`
load("@io_bazel_rules_cobol//cobol:def.bzl", "cobol_binary")

# Create a binary target named "hello_world"
cobol_binary(
    name = "hello_world",
    srcs = ["HELLO_WORLD.CBL"],
)
```

### `HELLO_WORLD.CBL`

Finally, create a `HELLO_WORLD.CBL` file and print "Hello, World!", of course.

```cobol
000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. HELLO_WORLD.
000300 DATA DIVISION.
000400 WORKING-STORAGE SECTION.
000500 77 FOO PIC 99 VALUE 43.
000600 PROCEDURE DIVISION.
000700     DISPLAY "Hello, World!" FOO
000800     STOP RUN.
```

Now, just run `bazel run //:hello_world` to build and execute your new COBOL
program using Bazel!

## Examples

An example of a COBOL program using `rules_cobol` can be found at
[Fuwn/bazel-cobol-example](https://github.com/Fuwn/bazel-cobol-example).

More examples can be found in the [`examples/`](examples) directory.

## License

This project is licensed with the
[BSD 3-Clause "New" or "Revised" License](LICENSE) and has been derived from
[jayconrad/rules_go_simple](https://github.com/jayconrod/rules_go_simple).
