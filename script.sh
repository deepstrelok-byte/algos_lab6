#!/bin/bash

# Проверка аргументов
if [ $# -lt 2 ]; then
    echo "Использование: $0 <суффикс> <максимальный_размер> [выходной_файл]"
    echo "Пример: $0 .txt 1000 result.txt"
    exit 1
fi

SUFFIX="$1"
MAX_SIZE="$2"
OUTPUT_FILE="${3:-merged.txt}"

# Поиск и объединение файлов
> "$OUTPUT_FILE"

for FILE in *"$SUFFIX"; do
    if [ -f "$FILE" ]; then
        FILE_SIZE=$(stat -c%s "$FILE" 2>/dev/null || stat -f%z "$FILE" 2>/dev/null)
        if [ "$FILE_SIZE" -lt "$MAX_SIZE" ]; then
            echo "Добавляю: $FILE ($FILE_SIZE байт)"
            echo "=== $FILE ===" >> "$OUTPUT_FILE"
            cat "$FILE" >> "$OUTPUT_FILE"
            echo "" >> "$OUTPUT_FILE"
        fi
    fi
done

echo "Готово! Результат в $OUTPUT_FILE"
