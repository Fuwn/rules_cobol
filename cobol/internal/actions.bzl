"""Common functions for creating actions to build COBOL programs"""

load("@bazel_skylib//lib:shell.bzl", "shell")

def cobol_compile_executable(ctx, srcs, out):
    """Compiles a single COBOL program from sources
    
    Args:
        ctx: the build context
        srcs: the source files to compile
        out: the output file
    """

    ctx.actions.run_shell(
        outputs = [out],
        inputs = srcs,
        command = "cobc -x -o {out} {srcs}".format(
            out = shell.quote(out.path),
            srcs = " ".join([shell.quote(src.path) for src in srcs]),
        ),
        mnemonic = "COBOLCompile",
        use_default_shell_env = True,
    )
