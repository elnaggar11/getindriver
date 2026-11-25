#!/usr/bin/env python3
import os
import sys
import json
import argparse
import datetime
import subprocess

def ensure_dependencies():
    """Ensure required Python packages are installed."""
    try:
        import googleapiclient
        import google.oauth2
    except ImportError:
        print("📦 Installing required Google API libraries...")
        subprocess.check_call([
            sys.executable, "-m", "pip", "install", "--break-system-packages",
            "google-api-python-client", "google-auth-httplib2", "google-auth-oauthlib"
        ])
        print("✅ Dependencies installed successfully.\n")

ensure_dependencies()

from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload
from google.oauth2 import service_account
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

SCOPES = ['https://www.googleapis.com/auth/drive']
DEFAULT_FOLDER_ID = '1wcPNx8-OKL73Kg8X16J2f7mv1GuX0YqC'

def get_drive_service(credentials_path):
    """Authenticate and return Google Drive service object."""
    if not credentials_path:
        script_dir = os.path.dirname(os.path.abspath(__file__))
        project_dir = os.path.dirname(script_dir)
        possible_paths = [
            os.path.join(project_dir, 'credentials.json'),
            os.path.join(script_dir, 'credentials.json'),
            'credentials.json',
            os.path.join(project_dir, 'service_account.json'),
            os.path.join(script_dir, 'service_account.json'),
            'service_account.json',
        ]
        for p in possible_paths:
            if os.path.exists(p):
                credentials_path = p
                break

    if not credentials_path or not os.path.exists(credentials_path):
        print("❌ Error: No Google credentials file found.")
        print("\nPlease follow these steps to set up OAuth authentication:")
        print("1. Go to Google Cloud Console (https://console.cloud.google.com/).")
        print("2. Navigate to APIs & Services -> Credentials -> Create Credentials -> OAuth client ID.")
        print("3. Select Application Type: 'Desktop App' and click Create.")
        print("4. Download the JSON key file, save it as 'credentials.json' in your project root.")
        sys.exit(1)

    print(f"🔑 Using credentials from: {credentials_path}")

    # Inspect JSON type
    try:
        with open(credentials_path, 'r') as f:
            data = json.load(f)
    except Exception as e:
        print(f"❌ Failed to read credentials JSON file: {e}")
        sys.exit(1)

    # Service Account Flow
    if data.get('type') == 'service_account':
        try:
            creds = service_account.Credentials.from_service_account_file(
                credentials_path, scopes=SCOPES
            )
            return build('drive', 'v3', credentials=creds)
        except Exception as e:
            print(f"❌ Service account authentication error: {e}")
            sys.exit(1)

    # OAuth 2.0 Desktop Flow (uses user storage quota)
    elif 'installed' in data or 'web' in data:
        try:
            creds = None
            token_path = os.path.join(os.path.dirname(credentials_path), 'token.json')
            if os.path.exists(token_path):
                creds = Credentials.from_authorized_user_file(token_path, SCOPES)
            if not creds or not creds.valid:
                if creds and creds.expired and creds.refresh_token:
                    creds.refresh(Request())
                else:
                    print("🌐 Opening browser to authorize Google Drive access...")
                    flow = InstalledAppFlow.from_client_secrets_file(credentials_path, SCOPES)
                    creds = flow.run_local_server(port=0)
                with open(token_path, 'w') as token:
                    token.write(creds.to_json())
            return build('drive', 'v3', credentials=creds)
        except Exception as e:
            print(f"❌ OAuth authentication failed: {e}")
            sys.exit(1)
    else:
        print("❌ Unknown JSON credential format. Must be Service Account key or OAuth Client ID JSON.")
        sys.exit(1)

def make_file_public(service, file_id):
    """Grant public read permission to the file."""
    try:
        service.permissions().create(
            fileId=file_id,
            body={'type': 'anyone', 'role': 'reader'},
            supportsAllDrives=True
        ).execute()
        print("🌐 Public permission set: Anyone with link can view/download.")
    except Exception as e:
        print(f"⚠️ Warning: Could not set public permission: {e}")

def upload_file(file_path, folder_id, credentials_path=None, custom_name=None, make_public=True):
    """Upload a file to Google Drive folder and return direct share link."""
    if not os.path.exists(file_path):
        print(f"❌ Error: File not found at path '{file_path}'")
        sys.exit(1)

    file_size_mb = os.path.getsize(file_path) / (1024 * 1024)
    file_basename = os.path.basename(file_path)
    
    if not custom_name:
        timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M")
        name, ext = os.path.splitext(file_basename)
        upload_name = f"{name}_{timestamp}{ext}"
    else:
        upload_name = custom_name

    print(f"🚀 Preparing to upload '{file_basename}' ({file_size_mb:.2f} MB) as '{upload_name}'...")
    print(f"📁 Target Folder ID: {folder_id}")

    service = get_drive_service(credentials_path)

    file_metadata = {
        'name': upload_name,
        'parents': [folder_id]
    }
    
    media = MediaFileUpload(file_path, resumable=True)

    try:
        request = service.files().create(
            body=file_metadata,
            media_body=media,
            fields='id, name, webViewLink, webContentLink',
            supportsAllDrives=True
        )

        response = None
        while response is None:
            status, response = request.next_chunk()
            if status:
                print(f"  Uploading... {int(status.progress() * 100)}%")

        file_id = response.get('id')
        web_link = response.get('webViewLink')

        if make_public:
            make_file_public(service, file_id)

        print("\n==========================================")
        print("🎉 UPLOAD SUCCESSFUL!")
        print("==========================================")
        print(f"📄 File Name: {response.get('name')}")
        print(f"🆔 File ID:   {file_id}")
        print(f"🔗 Public Link: {web_link}")
        print("==========================================")
        
        return web_link

    except Exception as e:
        print(f"❌ Upload failed: {e}")
        if "storageQuotaExceeded" in str(e) or "403" in str(e):
            print("\n💡 Reason & Solution for 403 Storage Quota Error:")
            print("Google Drive free Service Accounts have 0 bytes of personal storage quota.")
            print("When uploading files into a regular Google Drive folder, Google tries to charge quota to the uploader.\n")
            print("👉 Quick Solution (Recommended): Use OAuth 2.0 Credentials")
            print("1. Go to Google Cloud Console (https://console.cloud.google.com/).")
            print("2. Navigate to: APIs & Services -> Credentials -> Create Credentials -> OAuth client ID.")
            print("3. Select Application type: 'Desktop App' and click Create.")
            print("4. Click 'Download JSON', rename it to 'credentials.json', and place it in your project root:")
            print("   /Users/omarmahmoud/Desktop/flutter_projects/getin_driver/credentials.json")
            print("5. Delete 'service_account.json' (or keep both; credentials.json will be used automatically).")
            print("6. Run your script again. A browser window will pop up ONCE for sign-in, using your personal 15GB+ Drive quota!")
        sys.exit(1)

def main():
    parser = argparse.ArgumentParser(description="Upload APK to Google Drive folder and return public link")
    parser.add_argument("--file", "-f", required=True, help="Path to file to upload (e.g., APK)")
    parser.add_argument("--folder_id", "-g", default=DEFAULT_FOLDER_ID, help="Google Drive Folder ID")
    parser.add_argument("--credentials", "-c", default=None, help="Path to service_account.json or credentials.json")
    parser.add_argument("--name", "-n", default=None, help="Custom upload filename on Google Drive")
    parser.add_argument("--private", action="store_true", help="Do not make file public")

    args = parser.parse_args()
    upload_file(args.file, args.folder_id, args.credentials, args.name, make_public=not args.private)

if __name__ == "__main__":
    main()
