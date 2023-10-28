import argparse
import tarfile
import tempfile
import subprocess
import os
import stat


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', required=True)
    parser.add_argument('--arch', default="amd64")
    parser.add_argument("--chisel", default="chisel")
    options, slices = parser.parse_known_args()
    out_dir = tempfile.TemporaryDirectory()

    release_dir = "./chisel-release"
    arch = options.arch
    args = ["--release", release_dir, "--arch", arch, "--root", out_dir.name]
    result = subprocess.run([options.chisel, "cut"] + args + slices)
    if result.returncode != 0:
        return

    with tarfile.open(options.output, mode='w:') as out_file:
        for root, dirs, files in os.walk(top=out_dir.name):
            dir_prefix = root.removeprefix(out_dir.name)
            for dir_name in dirs:
                st = os.stat(root + "/" + dir_name)
                info = tarfile.TarInfo(name=dir_prefix + "/" + dir_name)
                info.type = tarfile.DIRTYPE
                info.mode = st.st_mode
                out_file.addfile(info)

            for file_name in files:
                st = os.lstat(root + "/" + file_name)
                info = tarfile.TarInfo(name=dir_prefix + "/" + file_name)
                info.uid = st.st_uid
                info.gid = st.st_gid
                if stat.S_ISLNK(st.st_mode):
                    info.type = tarfile.SYMTYPE
                    link = os.readlink(root + "/" + file_name)
                    if link[0] == '/':
                        link = link[1:]
                    info.linkname = link
                    out_file.addfile(info)
                else:
                    with open(root + "/" + file_name, mode='rb') as f:
                        info.size = st.st_size
                        info.mode = st.st_mode
                        out_file.addfile(info, fileobj=f)


if __name__ == '__main__':
    main()
