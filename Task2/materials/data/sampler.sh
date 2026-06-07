#!/usr/bin/env bash

BASE="$HOME/dataLAB/data/adbs_shared/Ex_2/stackexchange"
OUT="./sample"

mkdir -p "$OUT"

FILES=(
  "users.csv"
  "posts.csv"
  "comments.csv"
)

ROWS=10000

for f in "${FILES[@]}"; do

  SRC="$BASE/$f"
  DST="$OUT/$f"

  echo "Sampling $f -> $DST"

  {
    head -1 "$SRC"
    tail -n +2 "$SRC" | head -n "$ROWS"
  } > "$DST"

  echo "Created:"
  ls -lh "$DST"

  echo

done