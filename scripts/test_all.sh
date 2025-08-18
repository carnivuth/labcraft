#!/bin/bash
if [[ ! -d molecule ]]; then echo no molecule folder found; exit 1; fi
if [[ ! -d env ]]; then echo no env folder found; exit 1; fi
mkdir -p tests
source env/bin/activate
for d in molecule/*; do
  molecule test -s "$(basename "$d")" -- --vault-pass-file $(pwd)/passfile | tee tests/"$(basename "$d")".test &
done
