# 📲 FarmerEats - Installation Guide

## Quick Install on Android

### Method 1: Direct Installation (Recommended)
1. **Locate the APK:**
   - Navigate to: `build\app\outputs\flutter-apk\`
   - Find: `app-release.apk` (47.4 MB)

2. **Transfer to Phone:**
   - Connect phone via USB
   - Copy `app-release.apk` to phone's Downloads folder
   - OR send via email/messaging app
   - OR use cloud storage (Google Drive, Dropbox)

3. **Install:**
   - Open the APK file on your phone
   - If prompted, enable "Install from Unknown Sources"
   - Tap "Install"
   - Wait for installation to complete
   - Tap "Open" to launch the app

### Method 2: ADB Install (For Developers)
```bash
# Connect phone with USB debugging enabled
adb install build\app\outputs\flutter-apk\app-release.apk

# Or reinstall if already installed
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

---

## App Permissions

On first launch, the app may request:
- ✅ **Internet Access** - For API calls (auto-granted)
- ✅ **Storage Access** - For document upload (when uploading)
- ✅ **Camera Access** - For taking photos (when using camera)

All permissions are safe and required for app functionality.

---

## Testing Instructions

### 1. Splash Screen
- App launches with "FarmerEats" branding
- Automatically navigates after 2 seconds

### 2. Onboarding
- Swipe through 3 informational screens
- Each screen has different color theme
- Tap "Join the movement!" on any page
- Or tap "Login" to skip

### 3. Login
- Enter email and password
- Or use social login buttons (UI only)
- Tap "Forgot?" to test password recovery
- Valid format: any email + password (6+ chars)

### 4. Registration (Full Flow)

**Step 1 - Personal Info:**
- Full Name: John Doe
- Email: john@example.com
- Phone: +1234567890
- Password: password123
- Tap "Continue"

**Step 2 - Farm Info:**
- Business Name: Green Farm
- Informal Name: Johnny's Farm
- Address: 123 Farm Road
- City: Farmville
- State: Select from dropdown (e.g., California)
- Zip Code: 12345
- Tap "Continue"

**Step 3 - Verification:**
- Tap camera icon or upload area
- Select an image from gallery
- File will show with preview
- Tap "Continue"

**Step 4 - Business Hours:**
- Tap day circles to select (M, T, W, etc.)
- Tap "Add time slot" to add hours
- Can add multiple time slots
- Tap "Signup" to complete
- View success confirmation

### 5. Forgot Password Flow
- From login screen, tap "Forgot?"
- Enter phone: +1234567890
- Tap "Send Code"
- Enter 5-digit OTP (any 5 digits for testing)
- Tap "Submit"
- Enter new password twice
- Tap "Submit"
- Returns to login screen

---

## Troubleshooting

### "Installation Blocked"
**Solution:** Enable "Install from Unknown Sources"
1. Settings → Security → Unknown Sources (ON)
2. Or when prompted, tap "Settings" → Allow

### "App Not Installed"
**Solutions:**
- Make sure you have enough storage (50+ MB free)
- Try uninstalling any previous version first
- Restart phone and try again

### "App Crashes on Launch"
**Solutions:**
- Your Android version must be 5.0 or higher
- Clear app cache: Settings → Apps → FarmerEats → Clear Cache
- Reinstall the app

### "Cannot Upload Image"
**Solution:** Grant storage permission when prompted
- Settings → Apps → FarmerEats → Permissions → Storage (ON)

### "API Errors"
**Note:** The app requires internet connection for:
- Login
- Registration  
- Password recovery
- Make sure you're connected to WiFi or mobile data

---

## Testing API Endpoints

The app connects to:
```
https://sowlab.com/assignment/user/login
https://sowlab.com/assignment/user/register
https://sowlab.com/assignment/user/forgot-password
https://sowlab.com/assignment/user/verify-otp
https://sowlab.com/assignment/user/reset-password
```

**Note:** Actual API responses depend on backend implementation. The app will show success/error messages based on API responses.

---

## App Features

### ✅ Implemented
- Splash screen with branding
- 3-page onboarding flow
- Login with email/password
- Social login UI (Google, Apple, Facebook)
- 4-step registration process
- Image upload for documents
- Business hours configuration
- Forgot password flow
- OTP verification (5 digits)
- Password reset
- Success confirmation screens
- Form validation on all inputs
- Loading states for API calls
- Error handling with messages

### 🔜 Coming Soon (Future Enhancements)
- Actual social login implementation
- User dashboard/home screen
- Product management
- Order tracking
- Real-time notifications
- In-app messaging
- Profile editing

---

## Technical Details

**Package Name:** com.farmereats.sowlab  
**Version:** 1.0.0 (Build 1)  
**Min Android:** 5.0 (API 21)  
**File Size:** 47.4 MB  
**Architecture:** Universal APK (ARM, ARM64, x86, x86_64)  

---

## Support

For issues or questions about the app:
1. Check this installation guide
2. Review the troubleshooting section
3. Verify internet connection
4. Ensure Android 5.0 or higher
5. Check storage space available

---

## Development Info

**Built with:** Flutter 3.38.9  
**Build Date:** February 23, 2026  
**Build Type:** Release (Production)  
**Signing:** Debug keys (for testing)  

**For production deployment:** Replace with production signing keys

---

**Happy Testing! 🎉**

Create an account, explore the features, and experience the complete FarmerEats authentication flow!
