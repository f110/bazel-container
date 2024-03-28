package_dependencies = {
    "debian12": {
        "base-files": [],
        "base-passwd": ["libc6", "libdebconfclient0", "libgcc-s1", "libpcre2-8-0", "libselinux1"],
        "ca-certificates": ["debconf", "libc6", "libgcc-s1", "libssl3", "openssl"],
        "tzdata": ["debconf"],
        "netbase": [],
        "libc6": ["libc6", "libgcc-s1"],
        "libssl3": ["libc6", "libgcc-s1"],
        "coreutils": ["libacl1", "libattr1", "libc6", "libgcc-s1", "libgmp10", "libpcre2-8-0", "libselinux1"],
        "debianutils": ["libc6", "libgcc-s1"],
        "grep": ["dpkg", "libacl1", "libbz2-1.0", "libc6", "libgcc-s1", "liblzma5", "libmd0", "libpcre2-8-0", "libselinux1", "libzstd1", "tar", "zlib1g"],
        "sed": ["libacl1", "libc6", "libgcc-s1", "libpcre2-8-0", "libselinux1"],
        "findutils": ["libc6", "libgcc-s1", "libpcre2-8-0", "libselinux1"],
        "mawk": ["libc6", "libgcc-s1"],
        "g++": ["binutils", "binutils-x86-64-linux-gnu", "cpp", "cpp-12", "g++-12", "gcc", "gcc-12", "libasan8", "libatomic1", "libbinutils", "libc-dev-bin", "libc6", "libc6-dev", "libcc1-0", "libcom-err2", "libcrypt-dev", "libcrypt1", "libctf-nobfd0", "libctf0", "libgcc-12-dev", "libgcc-s1", "libgmp10", "libgomp1", "libgprofng0", "libgssapi-krb5-2", "libisl23", "libitm1", "libjansson4", "libk5crypto3", "libkeyutils1", "libkrb5-3", "libkrb5support0", "liblsan0", "libmpc3", "libmpfr6", "libnsl-dev", "libnsl2", "libquadmath0", "libssl3", "libstdc++-12-dev", "libstdc++6", "libtirpc-dev", "libtirpc3", "libtsan2", "libubsan1", "libzstd1", "rpcsvc-proto", "zlib1g"],
        "zip": ["libbz2-1.0", "libc6", "libgcc-s1"],
        "unzip": ["libbz2-1.0", "libc6", "libgcc-s1"],
        "tar": ["libacl1", "libc6", "libgcc-s1", "libpcre2-8-0", "libselinux1"],
        "gzip": ["dpkg", "libacl1", "libbz2-1.0", "libc6", "libgcc-s1", "liblzma5", "libmd0", "libpcre2-8-0", "libselinux1", "libzstd1", "tar", "zlib1g"],
        "patch": ["libc6", "libgcc-s1"],
        "linux-libc-dev": [],
        "curl": ["libbrotli1", "libc6", "libcom-err2", "libcurl4", "libdb5.3", "libffi8", "libgcc-s1", "libgmp10", "libgnutls30", "libgssapi-krb5-2", "libhogweed6", "libidn2-0", "libk5crypto3", "libkeyutils1", "libkrb5-3", "libkrb5support0", "libldap-2.5-0", "libnettle8", "libnghttp2-14", "libp11-kit0", "libpsl5", "librtmp1", "libsasl2-2", "libsasl2-modules-db", "libssh2-1", "libssl3", "libtasn1-6", "libunistring2", "libzstd1", "zlib1g"],
        "git": ["dpkg", "git-man", "libacl1", "libbrotli1", "libbz2-1.0", "libc6", "libcom-err2", "libcrypt1", "libcurl3-gnutls", "libdb5.3", "liberror-perl", "libexpat1", "libffi8", "libgcc-s1", "libgdbm-compat4", "libgdbm6", "libgmp10", "libgnutls30", "libgssapi-krb5-2", "libhogweed6", "libidn2-0", "libk5crypto3", "libkeyutils1", "libkrb5-3", "libkrb5support0", "libldap-2.5-0", "liblzma5", "libmd0", "libnettle8", "libnghttp2-14", "libp11-kit0", "libpcre2-8-0", "libperl5.36", "libpsl5", "librtmp1", "libsasl2-2", "libsasl2-modules-db", "libselinux1", "libssh2-1", "libssl3", "libtasn1-6", "libunistring2", "libzstd1", "perl", "perl-base", "perl-modules-5.36", "tar", "zlib1g"],
        "python3-minimal": ["dpkg", "libacl1", "libbz2-1.0", "libc6", "libexpat1", "libgcc-s1", "liblzma5", "libmd0", "libpcre2-8-0", "libpython3.11-minimal", "libselinux1", "libssl3", "libzstd1", "python3.11-minimal", "tar", "zlib1g"],
        "python3-distutils": ["python3-lib2to3"],
        "libpython3.11-stdlib": ["dpkg", "libacl1", "libbz2-1.0", "libc6", "libcom-err2", "libcrypt1", "libdb5.3", "libffi8", "libgcc-s1", "libgssapi-krb5-2", "libk5crypto3", "libkeyutils1", "libkrb5-3", "libkrb5support0", "liblzma5", "libmd0", "libncursesw6", "libnsl2", "libpcre2-8-0", "libpython3.11-minimal", "libreadline8", "libselinux1", "libsqlite3-0", "libssl3", "libtinfo6", "libtirpc3", "libuuid1", "libzstd1", "media-types", "readline-common", "tar", "zlib1g"],
        "bash": ["base-files", "debianutils", "libc6", "libgcc-s1", "libtinfo6"],
        "dash": ["debianutils", "dpkg", "libacl1", "libbz2-1.0", "libc6", "libgcc-s1", "liblzma5", "libmd0", "libpcre2-8-0", "libselinux1", "libzstd1", "tar", "zlib1g"],
        "automake": ["autoconf", "autotools-dev", "debianutils", "dpkg", "libacl1", "libbz2-1.0", "libc6", "libcrypt1", "libdb5.3", "libgcc-s1", "libgdbm-compat4", "libgdbm6", "liblzma5", "libmd0", "libpcre2-8-0", "libperl5.36", "libselinux1", "libzstd1", "m4", "perl", "perl-base", "perl-modules-5.36", "tar", "zlib1g"],
        "pkg-config": ["libc6", "libgcc-s1", "libpkgconf3", "pkgconf", "pkgconf-bin"],
    }
}

def deb_pkg(distro, *pkgs):
    all = {}
    for x in pkgs:
        all[x] = None
        for x in package_dependencies[distro][x]:
            all[x] = None
    return ["@%s_%s//:data" % (distro, k.replace("+", "_")) for k in all]