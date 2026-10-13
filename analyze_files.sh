#!/bin/bash
# Розширений скрипт для аналізу файлів (Самостійна робота №2)

# 1. Директорія: береться з 1-го аргументу або /etc за замовчуванням
TARGET_DIR="${1:-/etc}"

# Перевірка існування директорії
if [ ! -d "$TARGET_DIR" ]; then
   [cite: 1] echo "Помилка: директорія '$TARGET_DIR' не існує."
    exit 1
fi

# 2. Розширення файлів (опціональний 2-й аргумент, наприклад: conf, log, sh)
EXTENSION="$2"

echo "=================================================="
echo "Аналіз директорії: $TARGET_DIR"
if [ -n "$EXTENSION" ]; then
    echo "Фільтр за розширенням: *.$EXTENSION"
else
    echo "Фільтр за розширенням: усі файли"
fi
echo "=================================================="

# 3. Рекурсивний пошук файлів з урахуванням розширення чи без нього
if [ -n "$EXTENSION" ]; then
    files_list=$(find "$TARGET_DIR" -type f -name "*.$EXTENSION" 2>/dev/null)
else
    files_list=$(find "$TARGET_DIR" -type f 2>/dev/null)
fi

# Підрахунок кількості файлів
if [ -z "$files_list" ]; then
    file_count=0
else
    file_count=$(echo "$files_list" | wc -l)
fi

# 4. Підрахунок загального розміру знайдених файлів
total_size=0
if [ "$file_count" -gt 0 ]; then
    # Сумуємо розміри у байтах за допомогою stat та awk
    total_size=$(echo "$files_list" | xargs -d '\n' stat -c "%s" 2>/dev/null | awk '{s+=$1} END {print s+0}')
fi

# Форматування розміру для зручного читання (Байти / КБ / МБ)
if [ "$total_size" -ge 1048576 ]; then
    readable_size=$(awk "BEGIN {printf \"%.2f МБ\", $total_size / 1048576}")
elif [ "$total_size" -ge 1024 ]; then
    readable_size=$(awk "BEGIN {printf \"%.2f КБ\", $total_size / 1024}")
else
    readable_size="${total_size} байт"
fi

# Виведення підсумкової статистики
echo "Кількість знайдених файлів: $file_count"
echo "Загальний розмір файлів:  $readable_size ($total_size байт)"
echo "=================================================="

exit 0
