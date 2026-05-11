#!/usr/bin/env bash

BASE="$HOME/dataLAB/data/adbs_shared/Ex_2/stackexchange"

FILES=(
  "users.csv"
  "posts.csv"
  "comments.csv"
)

for f in "${FILES[@]}"; do

  FILE="$BASE/$f"

  echo "=================================================="
  echo "FILE: $FILE"
  echo "=================================================="

  echo
  echo "[SIZE]"
  ls -lh "$FILE"

  echo
  echo "[ENCODING / TYPE]"
  file "$FILE"

  echo
  echo "[LINE COUNT]"
  wc -l "$FILE"

  echo
  echo "[HEAD]"
  head -5 "$FILE"

  echo
  echo "[VISIBLE CONTROL CHARS]"
  head -3 "$FILE" | cat -A

  echo
  echo "[CSV FIELD COUNT CHECK]"
  awk -F',' '{print NF}' "$FILE" | sort -nu | head

  echo
  echo

done