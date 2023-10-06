**# SubSpaceBlog**

## Prerequisites

- Make sure you have [Flutter](https://flutter.dev/docs/get-started/install) installed on your system.
- Ensure you have a code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio) installed.
- You need to have Git installed to clone the repository.

## Getting Started

1. Clone the repository to your local machine using Git:

   ```bash
   git clone https://github.com/maranix/SubSpaceBlog.git
   ```

2. Navigate to the project directory:

   ```bash
   cd SubSpaceBlog
   ```

3. Install the project dependencies:

   ```bash
   flutter pub get
   ```

## Running the Project

Before running the project, you might need to define some environment variables. To do this, use the `--dart-define` flag with `flutter run` command.

To run the project on an emulator or a connected device, use the following command:

```bash
flutter run --dart-define=ADMIN_SECRET=YOUR_SECRET_API_KEY
```

## Building the Project

To build a release version of the app for Android or iOS, use the following command:

### Android

```bash
flutter build apk --release --dart-define=ADMIN_SECRET=YOUR_SECRET_API_KEY

```

The APK file will be located in the `build/app/outputs/apk/release/` directory.

### iOS

```bash
flutter build ios --release --dart-define=ADMIN_SECRET=YOUR_SECRET_API_KEY
```

The built iOS application will be located in the `build/ios/iphoneos/Runner.app` directory.

---

That's it! You should now have the Flutter project up and running on your local machine. If you encounter any issues or have questions, feel free to reach out to us. Happy coding!
