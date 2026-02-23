# FarmerEats - Mobile Application

A Flutter mobile application for farmers to sell products directly to consumers with REST API integration.

## Features

- **Splash Screen**: Beautiful welcome screen with app branding
- **Onboarding**: Three-screen onboarding flow introducing the app's features
  - Quality: Direct farm-to-consumer sales
  - Convenient: Delivery service integration
  - Local: Reduce carbon footprint
- **User Authentication**:
  - Login with email/password
  - Social login integration (Google, Apple, Facebook)
  - Register with comprehensive farmer information
  - Forgot password with OTP verification
  - Reset password functionality
- **Multi-step Registration**:
  - Step 1: Basic user information
  - Step 2: Farm business details
  - Step 3: Document verification
  - Step 4: Business hours configuration
- **REST API Integration**: Complete backend integration for all authentication flows

## Tech Stack

- **Framework**: Flutter 3.10.8+
- **Language**: Dart
- **Dependencies**:
  - `http`: REST API communication
  - `shared_preferences`: Local data storage
  - `google_fonts`: Custom typography
  - `file_picker`: Document upload
  - `smooth_page_indicator`: Onboarding indicators

## Project Structure

```
lib/
├── constants/
│   ├── colors.dart         # App color palette
│   └── strings.dart        # App constants
├── models/
│   └── user_model.dart     # Data models for API requests
├── services/
│   └── api_service.dart    # REST API service layer
├── screens/
│   ├── splash_screen.dart
│   ├── onboarding_screen.dart
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── signup_farm_info_screen.dart
│   ├── signup_verification_screen.dart
│   ├── signup_hours_screen.dart
│   ├── signup_confirmation_screen.dart
│   ├── forgot_password_screen.dart
│   ├── verify_otp_screen.dart
│   └── reset_password_screen.dart
└── main.dart
```

## API Endpoints

Base URL: `https://sowlab.com/assignment`

### Authentication Endpoints:
- `POST /user/login` - User login
- `POST /user/register` - User registration
- `POST /user/forgot-password` - Request password reset
- `POST /user/verify-otp` - Verify OTP code
- `POST /user/reset-password` - Reset password

## Getting Started

### Prerequisites
- Flutter SDK (3.10.8 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android Emulator or Physical Device / iOS Simulator

### Installation

1. Navigate to project directory:
```bash
cd sowlab
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Build for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## App Flow

1. **Splash Screen** → Displays app logo and name (2 seconds)
2. **Onboarding** → Three screens with swipeable cards explaining app features
3. **Login/Signup** → User can choose to login or create account
4. **Registration Flow**:
   - Personal information (name, email, phone, password)
   - Farm business details (business name, address, location)
   - Document verification (registration proof upload)
   - Business hours (select days and time slots)
   - Confirmation screen
5. **Password Recovery**:
   - Enter phone number
   - Verify OTP (5-digit code)
   - Set new password

## Color Scheme

- Primary Green: `#5EA25F` - Main actions, success states
- Primary Red: `#D5715B` - CTAs, important actions
- Primary Yellow: `#F8C569` - Highlights, accents
- Background: `#FFF5F1` - Light warm background
- Text Dark: `#261C12` - Primary text color
- Text Grey: `#A0A0A0` - Secondary text, placeholders

## Design System

The UI follows the Figma design specifications provided, ensuring:
- Consistent spacing and padding
- Proper typography hierarchy
- Accessible color contrast
- Smooth transitions and animations
- Material Design 3 components

## API Request Models

### Login
```json
{
  "email": "johndoe@mail.com",
  "password": "12345678",
  "role": "farmer",
  "device_token": "...",
  "type": "email/facebook/google/apple",
  "social_id": "..."
}
```

### Register
```json
{
  "full_name": "john doe",
  "email": "johndoe@mail.com",
  "phone": "+19876543210",
  "password": "12345678",
  "role": "farmer",
  "business_name": "Dairy Farm",
  "informal_name": "London Dairy",
  "address": "3663 Marshville Road",
  "city": "Poughkeepsie",
  "state": "New York",
  "zip_code": 12601,
  "registration_proof": "my_proof.pdf",
  "business_hours": {...},
  "device_token": "...",
  "type": "email/facebook/google/apple",
  "social_id": "..."
}
```

## Future Enhancements

- Implement actual social login (Google, Apple, Facebook)
- Add user dashboard/home screen
- Implement product listing and management
- Add order management system
- Implement real-time notifications
- Add analytics and reporting
- Implement chat/messaging feature

## License

This project is part of the SowLab assignment.

## Author

Developed as per SowLab assignment specifications.
