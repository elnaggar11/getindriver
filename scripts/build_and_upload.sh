#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Configuration
FLUTTER_BIN="/Users/omarmahmoud/development/flutter/bin/flutter"
PYTHON_BIN="/opt/homebrew/bin/python3"
GDRIVE_FOLDER_ID="1wcPNx8-OKL73Kg8X16J2f7mv1GuX0YqC"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=========================================="
echo "🚀 Starting Flutter Build & Upload Pipeline"
echo "=========================================="
echo "Project Directory: ${PROJECT_DIR}"
echo "Flutter SDK Path:  ${FLUTTER_BIN}"
echo "Drive Folder ID:   ${GDRIVE_FOLDER_ID}"
echo "=========================================="

cd "${PROJECT_DIR}"

BUILD_MODE=""

# Check command line arguments first
for arg in "$@"; do
  case $arg in
    --split|-s)
      BUILD_MODE="split"
      shift
      ;;
    --single|--fat|-f)
      BUILD_MODE="single"
      shift
      ;;
  esac
done

# If build mode was not passed via CLI, prompt interactively
if [ -z "${BUILD_MODE}" ]; then
  echo ""
  echo "Select Android APK build mode:"
  echo "  1) Universal Single APK (fat release)"
  echo "  2) Split per ABI (builds all, uploads arm64-v8a only)"
  echo ""
  read -p "Enter choice [1 or 2] (default: 1): " choice

  case "${choice}" in
    2)
      BUILD_MODE="split"
      ;;
    *)
      BUILD_MODE="single"
      ;;
  esac
fi

APK_PATH=""

if [ "${BUILD_MODE}" == "split" ]; then
  echo ""
  echo "📱 [1/3] Building Android APK (Split per ABI)..."
  "${FLUTTER_BIN}" build apk --release --split-per-abi
  APK_PATH="${PROJECT_DIR}/build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"
else
  echo ""
  echo "📱 [1/3] Building Android APK (Universal Single APK)..."
  "${FLUTTER_BIN}" build apk --release
  APK_PATH="${PROJECT_DIR}/build/app/outputs/flutter-apk/app-release.apk"
fi

if [ ! -f "${APK_PATH}" ]; then
  echo "❌ Error: APK build failed! Target artifact not found at ${APK_PATH}"
  exit 1
fi

echo "✅ Selected APK artifact ready: ${APK_PATH}"

# 2. Always Build iOS
echo ""
echo "🍏 [2/3] Building iOS Release App (keeping both iOS and Android)..."
"${FLUTTER_BIN}" build ios --release
echo "✅ iOS build completed successfully."

# 3. Upload Selected APK to Google Drive (Make Public & Return Share Link)
echo ""
echo "☁️ [3/3] Uploading APK to Google Drive and setting public sharing link..."
"${PYTHON_BIN}" "${PROJECT_DIR}/scripts/upload_gdrive.py" \
  --file "${APK_PATH}" \
  --folder_id "${GDRIVE_FOLDER_ID}"

echo ""
echo "=========================================="
echo "🎉 Build & Upload Pipeline Completed Successfully!"
echo "=========================================="
