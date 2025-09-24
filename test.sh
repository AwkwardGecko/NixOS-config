cd "$HOME/.local/share/Steam/steamapps/common/Borderlands 2" || exit
mkdir -p lib.bak
for f in lib/libcurl.so* lib/libssl.so* lib/libcrypto.so*; do
  [ -e "$f" ] && mv -v "$f" lib.bak/
done

