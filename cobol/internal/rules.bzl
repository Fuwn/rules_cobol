"Rules for building COBOL programs"

load(":actions.bzl", "cobol_compile_executable")

def _cobol_binary_impl(ctx):
    prefix = ctx.label.name + "%/"
    executable = ctx.actions.declare_file(prefix + ctx.label.name)

    cobol_compile_executable(
        ctx,
        srcs = ctx.files.srcs,
        out = executable,
    )

    return [DefaultInfo(
        files = depset([executable]),
        executable = executable,
    )]

cobol_binary = rule(
    _cobol_binary_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
            doc = "The COBOL source files to compile for this binary",
        ),
    },
    doc = "Builds an executable program from COBOL source code",
    executable = True,
)
