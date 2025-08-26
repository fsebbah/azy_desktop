# Azy Desktop

Flutter Desktop application for Azy Chat Studio - A modern chat interface with AI capabilities.

## Features

- 🔐 Modern login interface with email/password authentication
- 🎨 Beautiful UI with gradient backgrounds and animations
- 🌙 Dark/Light theme support
- 💻 Multi-platform support (Windows, Linux, macOS)
- 🚀 Built with Flutter for optimal performance

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Platform-specific requirements:
  - **Linux**: GTK development libraries
  - **Windows**: Visual Studio 2019 or later
  - **macOS**: Xcode and CocoaPods

### Installation

1. Clone the repository:
```bash
git clone git@github.com:fsebbah/azy_desktop.git
cd azy_desktop
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
# For Linux
flutter run -d linux

# For Windows  
flutter run -d windows

# For macOS
flutter run -d macos
```

## Project Structure

```
azy_desktop/
├── lib/
│   ├── main.dart              # Application entry point
│   └── screens/
│       └── login_screen.dart  # Login interface
├── android/                   # Android platform files
├── ios/                       # iOS platform files
├── linux/                     # Linux desktop files
├── macos/                     # macOS desktop files
├── windows/                   # Windows desktop files
└── web/                       # Web platform files
```

## Development

### Build for production

```bash
# Linux
flutter build linux --release

# Windows
flutter build windows --release

# macOS
flutter build macos --release
```

## Migration from Vue.js

This project is being migrated from a Vue.js web application to a Flutter Desktop application for improved performance and native desktop integration.

### Current Implementation Status

- ✅ Project setup and configuration
- ✅ Login screen UI
- 🚧 Authentication logic
- 🚧 WebSocket integration
- 📋 Chat interface
- 📋 User management
- 📋 Conversation handling

## Contributing

Please read our contributing guidelines before submitting PRs.

## License

This project is proprietary software. All rights reserved.