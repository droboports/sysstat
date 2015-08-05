CFLAGS="${CFLAGS:-} -ffunction-sections -fdata-sections"
LDFLAGS="-L${DEST}/lib -L${DEPS}/lib -Wl,--gc-sections"

### SYSSTAT ###
_build_sysstat() {
local VERSION="11.1.5"
local FOLDER="sysstat-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://pagesperso-orange.fr/sebastien.godard/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="" --mandir="/man" \
  --disable-sensors \
  --disable-file-attr \
  --without-systemdsystemunitdir
make
make install DESTDIR="${DEST}"
"${STRIP}" -s -R .comment -R .note -R .note.ABI-tag "${DEST}/bin/"*
popd
}

_build_rootfs() {
# /bin/iostat
  return 0
}

_build() {
  _build_sysstat
  _package
}
