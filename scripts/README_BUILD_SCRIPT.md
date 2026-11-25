# Flutter Build & Google Drive Upload Guide

Automated script pipeline to build Android (APK) and iOS release binaries, prompt for **Single APK** vs **Split-per-ABI APK**, upload the artifact to Google Drive (`1wcPNx8-OKL73Kg8X16J2f7mv1GuX0YqC`), make the file public, and return a share link.

---

## 🛠️ Step 1: Google Drive Credentials (One-Time Setup)

Ensure `service_account.json` is placed in the project root:
`/Users/omarmahmoud/Desktop/flutter_projects/getin_driver/service_account.json`

Make sure the Google Drive folder (`1wcPNx8-OKL73Kg8X16J2f7mv1GuX0YqC`) is shared with the Service Account email as **Editor**.

---

## 🚀 Step 2: Running the Script

Run in your terminal:

```bash
./scripts/build_and_upload.sh
```

### Options:

1. **Interactive Prompt**:
   - The script will ask:
     ```text
     Select Android APK build mode:
       1) Universal Single APK (fat release)
       2) Split per ABI (builds all, uploads arm64-v8a only)
     ```
2. **Command Line Flags** (bypass interactive prompt):
   - For Split per ABI:
     ```bash
     ./scripts/build_and_upload.sh --split
     ```
   - For Universal Single APK:
     ```bash
     ./scripts/build_and_upload.sh --single
     ```

### Pipeline Flow:
1. **Android Build**:
   - Mode 1: `flutter build apk --release` -> uploads `app-release.apk`
   - Mode 2: `flutter build apk --release --split-per-abi` -> uploads `app-arm64-v8a-release.apk`
2. **iOS Build**:
   - Always builds iOS release target (`flutter build ios --release`).
3. **Public Sharing & Link Generation**:
   - Uploads to Google Drive folder `1wcPNx8-OKL73Kg8X16J2f7mv1GuX0YqC`.
   - Grants public read access (`anyone` reader role).
   - Prints the public share URL directly in terminal output.
