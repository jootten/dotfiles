if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  export QT_QPA_PLATFORMTHEME='qt5ct'
  exec startx
fi
