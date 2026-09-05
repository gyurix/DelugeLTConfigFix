#!/bin/bash
# Builds the fixed plugin file from the sources in src/.
# Result: ltConfig-2.0.0-fixed.egg in this folder.
set -e
cd "$(dirname "$0")"
rm -f ltConfig-2.0.0-fixed.egg
cd src
zip -qr ../ltConfig-2.0.0-fixed.egg . -x '*/__pycache__/*' '*.pyc' '*.pyo'
cd ..
unzip -t ltConfig-2.0.0-fixed.egg > /dev/null
echo "Built OK: $(pwd)/ltConfig-2.0.0-fixed.egg"
unzip -l ltConfig-2.0.0-fixed.egg | head -n 12
