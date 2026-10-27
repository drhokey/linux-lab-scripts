#!/bin/bash
if [ "$1" = "--help" ]; then
    echo "Використання: count_files [опції]"
    echo "Рахує кількість звичайних файлів у цільовій директорії."
    exit 0
fi

CONFIG="/etc/count-files.conf"
if [ -f "$CONFIG" ]; then
    source "$CONFIG"
else
    TARGET_DIR="/etc"
fi
echo "Версія 2.0: Підрахунок файлів у каталозі $TARGET_DIR:"
find "$TARGET_DIR" -maxdepth 1 -type f | wc -l
