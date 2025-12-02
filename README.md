# 🎯 HashtagFlow

A beautiful Flutter application for creating and managing phrases with smart hashtag detection and highlighting.

## 📱 Features

- **Three-Screen Navigation**: Seamless navigation between screens using `go_router`
- **Smart Hashtag Detection**: Automatically detects and highlights hashtags in real-time
- **Auto-Population**: Hashtags are automatically extracted from phrases and populated
- **Colorful Hashtags**: Each hashtag is displayed in a unique, vibrant color
- **Beautiful UI**: Modern, gradient-based design with smooth animations
- **MVVM Architecture**: Clean separation of concerns with ViewModels
- **Localization Support**: Ready for multiple languages

## 🏗️ Architecture

This project follows **MVVM (Model-View-ViewModel)** architecture pattern:

```
lib/
├── config/              # Route configuration and transitions
│   ├── app_routes.dart
│   ├── app_router.dart
│   └── route_transitions.dart
├── view/                # UI Layer (Views)
│   └── screens/
│       ├── screen_a.dart
│       ├── screen_b.dart
│       └── screen_c.dart
├── view_model/          # Business Logic Layer
│   ├── base_vm.dart
│   ├── screen_a_vm.dart
│   ├── screen_b_vm.dart
│   └── screen_c_vm.dart
├── widgets/             # Reusable UI components
│   ├── custom_button.dart
│   ├── custom_text.dart
│   └── custom_textfield.dart
├── utils/               # Utilities and helpers
│   ├── color_resources.dart
│   └── extension.dart
└── l10n/                # Localization files
    └── app_en.arb
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio (recommended IDE)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/flutterdeveloper706/queue_free.git
cd queue_free
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate localization files:
```bash
flutter gen-l10n
```

4. Run the app:
```bash
flutter run
```

## 📖 App Flow

### Screen A → Screen B → Screen C → Screen B → Screen A

1. **Screen A**: Welcome screen with navigation button
2. **Screen B**: 
   - Empty state: Shows feature cards and navigation to Screen C
   - With data: Displays phrase and hashtags with highlighted hashtags
3. **Screen C**: 
   - Phrase input field with real-time hashtag highlighting
   - Hashtags field with auto-population
   - Submit button to save and navigate back

## 🎨 Features in Detail

### Real-Time Hashtag Highlighting
As you type in the Phrase field, hashtags are automatically detected and highlighted in different colors.

### Auto-Population
Hashtags from the Phrase field are automatically extracted and populated into the Hashtags field.

### Colorful Hashtags
Each hashtag gets a unique color from a vibrant palette, making them easy to identify.

### Beautiful Transitions
Smooth slide transitions between screens for a polished user experience.

## 🛠️ Technologies Used

- **Flutter**: Cross-platform UI framework
- **go_router**: Declarative routing for Flutter
- **Provider**: State management
- **flutter_screenutil**: Responsive UI design
- **flutter_localizations**: Internationalization support

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  go_router: ^14.0.0
  flutter_screenutil: ^5.9.0
  provider: ^6.1.1
  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2
```

## 🎯 Project Structure

### Routes & Navigation
- Routes are defined in `lib/config/app_routes.dart`
- Router configuration in `lib/config/app_router.dart`
- Custom transitions in `lib/config/route_transitions.dart`

### ViewModels
- Base ViewModel with common functionality
- Screen-specific ViewModels for business logic
- State management using Provider

### Views
- Stateless widgets for UI rendering
- Consumer widgets for reactive updates
- Clean separation from business logic

## 🎨 Design System

### Colors
- Primary: `#031733`
- Background: `#0d121e`
- Button: `#15a5be`
- Hashtag Colors: 10 vibrant colors in rotation

### Typography
- Font Family: Rajdhani
- Responsive sizing using ScreenUtil

## 📱 Screenshots

### Screen A
Welcome screen with gradient background and navigation button.

### Screen B
- Empty state with feature cards
- Data display with highlighted hashtags

### Screen C
Input screens with real-time hashtag highlighting and auto-population.

## 🔧 Development

### Running Tests
```bash
flutter test
```

### Building for Production
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 📝 Code Style

- Follows Flutter/Dart style guidelines
- Uses `flutter_lints` for code quality
- MVVM pattern for architecture
- Clean code principles

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

**Flutter Developer**

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- go_router package maintainers
- Provider package maintainers

---

Made with ❤️ using Flutter
# hashtagflow
