# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
aes-0.6.0
aes-soft-0.6.4
aesni-0.10.0
aho-corasick-0.7.19
ansi_term-0.12.1
anyhow-1.0.65
arrayvec-0.5.2
assert_matches-1.5.0
atty-0.2.14
autocfg-1.1.0
base-x-0.2.11
bitflags-1.3.2
bitvec-0.19.6
bumpalo-3.11.0
byte-slice-cast-1.2.1
byteorder-1.4.3
c_linked_list-1.1.1
cfb-mode-0.6.0
cfg-expr-0.8.1
cfg-if-0.1.10
cfg-if-1.0.0
cipher-0.2.5
clap-2.34.0
const_fn-0.4.9
cookie-factory-0.3.2
crc32fast-1.3.2
crossbeam-0.7.3
crossbeam-channel-0.4.4
crossbeam-channel-0.5.6
crossbeam-deque-0.7.4
crossbeam-epoch-0.8.2
crossbeam-queue-0.2.3
crossbeam-utils-0.7.2
crossbeam-utils-0.8.11
discard-1.0.4
either-1.8.0
env_logger-0.9.0
err-derive-0.2.4
form_urlencoded-1.1.0
funty-1.1.0
futures-channel-0.3.24
futures-core-0.3.24
futures-executor-0.3.24
futures-io-0.3.24
futures-sink-0.3.24
futures-task-0.3.24
futures-util-0.3.24
gcc-0.3.55
generic-array-0.14.6
get_if_addrs-0.5.3
get_if_addrs-sys-0.1.1
getrandom-0.2.7
gio-0.14.8
gio-sys-0.14.0
glib-0.14.8
glib-macros-0.14.1
glib-sys-0.14.0
gobject-sys-0.14.0
gstreamer-0.17.4
gstreamer-app-0.17.2
gstreamer-app-sys-0.17.0
gstreamer-base-0.17.2
gstreamer-base-sys-0.17.0
gstreamer-net-0.17.0
gstreamer-net-sys-0.17.0
gstreamer-rtsp-0.17.0
gstreamer-rtsp-server-0.17.2
gstreamer-rtsp-server-sys-0.17.0
gstreamer-rtsp-sys-0.17.0
gstreamer-sdp-0.17.0
gstreamer-sdp-sys-0.17.0
gstreamer-sys-0.17.3
heck-0.3.3
hermit-abi-0.1.19
humantime-2.1.0
idna-0.2.3
idna-0.3.0
if_chain-1.0.2
indoc-0.3.6
indoc-impl-0.3.6
itertools-0.9.0
itertools-0.10.4
itoa-1.0.3
lazy_static-1.4.0
lexical-core-0.7.6
libc-0.2.132
local-ip-address-0.4.8
log-0.4.17
matches-0.1.9
maybe-uninit-2.0.0
md5-0.7.0
memchr-2.5.0
memoffset-0.5.6
muldiv-1.0.0
neli-0.5.3
nom-6.1.2
num-integer-0.1.45
num-rational-0.4.1
num-traits-0.2.15
once_cell-1.14.0
opaque-debug-0.3.0
paste-1.0.9
percent-encoding-2.2.0
pin-project-lite-0.2.9
pin-utils-0.1.0
pkg-config-0.3.25
ppv-lite86-0.2.16
pretty-hex-0.2.1
proc-macro-crate-1.2.1
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro-hack-0.5.19
proc-macro2-1.0.43
quote-1.0.21
radium-0.5.3
rand-0.8.5
rand_chacha-0.3.1
rand_core-0.6.4
regex-1.6.0
regex-syntax-0.6.27
rustc_version-0.2.3
rustversion-1.0.9
ryu-1.0.11
scopeguard-1.1.0
semver-0.9.0
semver-parser-0.7.0
serde-1.0.144
serde_derive-1.0.144
serde_json-1.0.85
sha1-0.6.1
sha1_smol-1.0.0
slab-0.4.7
smallvec-1.9.0
socket2-0.3.19
standback-0.2.17
static_assertions-1.1.0
stdweb-0.4.20
stdweb-derive-0.5.3
stdweb-internal-macros-0.2.9
stdweb-internal-runtime-0.1.5
strsim-0.8.0
structopt-0.3.26
structopt-derive-0.4.18
strum-0.21.0
strum_macros-0.21.1
syn-1.0.99
synstructure-0.12.6
system-deps-3.2.0
tap-1.0.1
termcolor-1.1.3
textwrap-0.11.0
thiserror-1.0.35
thiserror-impl-1.0.35
time-0.2.27
time-macros-0.1.1
time-macros-impl-0.1.2
tinyvec-1.6.0
tinyvec_macros-0.1.0
toml-0.5.9
typenum-1.15.0
unicode-bidi-0.3.8
unicode-ident-1.0.4
unicode-normalization-0.1.21
unicode-segmentation-1.10.0
unicode-width-0.1.10
unicode-xid-0.2.4
unindent-0.1.10
url-2.3.1
validator-0.10.1
validator_derive-0.10.1
vec_map-0.8.2
version-compare-0.0.11
version_check-0.9.4
wasi-0.11.0+wasi-snapshot-preview1
wasm-bindgen-0.2.83
wasm-bindgen-backend-0.2.83
wasm-bindgen-macro-0.2.83
wasm-bindgen-macro-support-0.2.83
wasm-bindgen-shared-0.2.83
winapi-0.2.8
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
windows-sys-0.36.1
windows_aarch64_msvc-0.36.1
windows_i686_gnu-0.36.1
windows_i686_msvc-0.36.1
windows_x86_64_gnu-0.36.1
windows_x86_64_msvc-0.36.1
wyz-0.2.0
xml-rs-0.8.4
yaserde-0.3.16
yaserde_derive-0.3.17
"

inherit cargo

GIT_COMMIT="d75e416c96b9867875bc7252777302e8cec214ab"
DESCRIPTION="Connect to your Reolink camera from Linux"
HOMEPAGE="https://github.com/thirtythreeforty/neolink"
SRC_URI="https://github.com/thirtythreeforty/neolink/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz
$(cargo_crate_uris)"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

DEPEND="${RDEPEND}
	media-libs/gst-plugins-bad
	media-libs/gst-plugins-good
	media-libs/gst-rtsp-server
	virtual/rust"

S="${WORKDIR}/${PN}-${GIT_COMMIT}"
