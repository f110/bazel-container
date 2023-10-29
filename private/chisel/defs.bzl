ChiselToolchain = provider(
    fields = {
        "version": "",
        "bin": "",
    },
)
ChiselSlice = provider(
    fields = {
        "name": "",
        "slice": "",
        "files": "",
    },
)

def _chisel_toolchain(ctx):
    return [ChiselToolchain(
        version = ctx.attr.version,
        bin = ctx.attr.bin,
    )]

chisel_toolchain = rule(
    implementation = _chisel_toolchain,
    attrs = {
        "version": attr.string(mandatory = True),
        "bin": attr.label(executable = True, cfg = "host"),
    },
)

def _chisel_tar_impl(ctx):
    args = ctx.actions.args()
    args.add_all(["--chisel", ctx.executable._chisel.path])

    srcs = [ctx.file.release]
    for s in ctx.attr.slices:
        slice = s[ChiselSlice]
        srcs.extend(slice.files)

    slices = ["%s_%s" % (s[ChiselSlice].name, s[ChiselSlice].slice) for s in ctx.attr.slices]

    out_file = ctx.actions.declare_file("%s.tar" % ctx.label.name)
    args.add_all(["--output", out_file.path])
    args.add_all(slices)
    ctx.actions.run(
        executable = ctx.executable._wrapper,
        outputs = [out_file],
        inputs = srcs + [ctx.executable._chisel],
        arguments = [args],
        mnemonic = "Chisel",
    )
    return [
        DefaultInfo(files = depset([out_file])),
    ]

chisel_tar = rule(
    implementation = _chisel_tar_impl,
    attrs = {
        "release": attr.label(allow_single_file = [".yaml", ".yml"]),
        "slices": attr.label_list(providers = [ChiselSlice]),
        "arch": attr.string(default = "amd64", values = ["amd64"]),
        "_wrapper": attr.label(default = Label("//private/chisel:build"), executable = True, cfg = "exec", allow_files = True),
        "_chisel": attr.label(default = "@com_github_canonical_chisel//cmd/chisel", executable = True, cfg = "host"),
    },
)

def _chisel_slice_impl(ctx):
    package_name = ctx.attr.package_name
    if not package_name:
        package_name = ctx.label.name

    return [
        DefaultInfo(files = depset(direct = [ctx.file.src], transitive = [depset(ctx.files.deps)])),
        ChiselSlice(
            name = package_name,
            slice = ctx.attr.slice,
            files = [ctx.file.src] + ctx.files.deps,
        ),
    ]

chisel_slice = rule(
    implementation = _chisel_slice_impl,
    attrs = {
        "src": attr.label(allow_single_file = [".yaml", ".yml"]),
        "package_name": attr.string(),
        "slice": attr.string(mandatory = True),
        "deps": attr.label_list(providers = [ChiselSlice]),
    },
)
