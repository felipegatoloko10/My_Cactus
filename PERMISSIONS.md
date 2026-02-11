# Permissions Setup

To enable Camera and Notifications, you must add the following permissions to your platform-specific configuration files.

## Android (`android/app/src/main/AndroidManifest.xml`)

Add these lines before the `<application>` tag:

```xml
<uses-permission android:name="android.permission.AMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.VIBRATE"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
```

*Note: For Android 13+ you might need granular media permissions.*

Inside the `<application>` tag, add/ensure receivers for scheduled notifications if required by the legacy setup, but mostly `flutter_local_notifications` handles it. However, always check the plugin documentation for the exact version.

## iOS (`ios/Runner/Info.plist`)

Add these keys to the dict:

```xml
<key>NSCameraUsageDescription</key>
<string>We need access to the camera to take photos of your plants.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to the gallery to pick photos of your plants.</string>
```
