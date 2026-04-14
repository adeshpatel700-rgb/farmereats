# FarmerEats

FarmerEats is a Flutter mobile app for farmer onboarding and authentication.

## Features

- Splash and onboarding flow
- Login and signup (multi-step)
- Forgot password, OTP verification, and reset password
- Farmer profile registration with document upload and business hours
- Clean architecture structure (core, features, data, domain, presentation)

## Tech Stack

- Flutter
- Dio
- flutter_bloc
- go_router
- get_it

## Project Structure

- `lib/core` shared theme, widgets, network, storage, utilities
- `lib/features` feature modules (auth, onboarding, splash, home)
- `assets/images` UI icons and onboarding illustrations

## Run Locally

1. Install Flutter SDK
2. Clone this repository
3. Run:

```bash
flutter pub get
flutter run
```

## Notes

- This repository is focused on Android and iOS app flow.
- Social login buttons are present in UI, but backend SDK wiring can be extended further.
