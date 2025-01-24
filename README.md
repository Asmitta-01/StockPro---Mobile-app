# Inventory Management App : StockPro

This Android application is designed to streamline inventory management for businesses of all sizes. With this app, you can:

- Track inventory: Easily add, edit, and delete inventory items.
- Manage stock levels: Monitor stock levels and set low-stock alerts.
- Generate reports: Create detailed reports on inventory levels, sales, and purchases.
- Optimize inventory: Make data-driven decisions to improve inventory efficiency.

This app is perfect for retailers, wholesalers, and small businesses. It's easy to use, efficient, and customizable to fit your specific needs.

## Features

- User-friendly interface for managing inventory
- Real-time stock tracking and alerts
- Detailed reporting and analytics
- Multi-language support (English and French)

## Technologies Used

- Flutter (Channel stable, 3.24.3, on Microsoft Windows [version 10.0.26100.2894], locale fr-FR)
- Windows Version 11
- Android toolchain - develop for Android devices (Android SDK version 34.0.0)
- Visual Studio - develop Windows apps (Visual Studio Community 2022 17.9.0)
- Android Studio (version 2024.1)
- VS Code (version 1.96.3)

## Getting Started

To run this project locally:

1. Ensure you have Flutter installed on your machine.
2. Clone this repository.
3. Run `flutter pub get` to install dependencies.
4. Run `dart run build_runner build` to generate __*.g.dart__ files (Needed in models).
5. If you're in debug mode, edit [android/app/build.gradle](./android/app/build.gradle#L50) and replace `signingConfig = signingConfigs.release` by `signingConfig = signingConfigs.debug`.
6. Connect a device or start an emulator.
7. Run `flutter run` to start the app.

For more information on Flutter development, check out the [Flutter documentation](https://flutter.dev/docs).
