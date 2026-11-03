# Nova Fintech

<div align="center">

<p><strong>FINTECH MOBILE APP PROTOTYPE</strong></p>

<img src="https://img.shields.io/badge/Flutter-0F172A?style=for-the-badge" alt="Flutter" />
<img src="https://img.shields.io/badge/Dart-0F172A?style=for-the-badge" alt="Dart" />
<img src="https://img.shields.io/badge/Riverpod-0F172A?style=for-the-badge" alt="Riverpod" />

<a href="https://github.com/rahat-codes/nova_fintech"><img src="https://img.shields.io/github/stars/rahat-codes/nova_fintech?style=social" alt="GitHub stars" /></a>

</div>

---

A modern fintech mobile application prototype built with Flutter and Dart. The project focuses on a polished mobile experience, reusable UI structure, and a foundation for adding real financial-product functionality.

> **Project status:** Portfolio/demo application. It is not a real banking service and does not process real payments or hold customer funds.

## Highlights

- Flutter-based cross-platform mobile application.
- Modular code organization across app, core, data, and feature layers.
- Declarative navigation with GoRouter.
- Riverpod for state-management foundations.
- Animated UI elements and custom typography.
- Currency and date formatting support.

## Technology Stack

| Area | Technology |
|---|---|
| UI & application | Flutter, Dart |
| Navigation | GoRouter |
| State management | Flutter Riverpod |
| Typography | Google Fonts |
| Animations | flutter_animate |
| UI components | smooth_page_indicator |
| Formatting | intl |

## Project Structure

```text
lib/
├── app/
├── core/
├── data/
├── features/
└── main.dart
```

## Getting Started

### Requirements

- Flutter SDK compatible with the Dart SDK constraint in `pubspec.yaml`
- Android Studio or Visual Studio Code
- Android emulator or physical device (or an available iOS development environment)

### Run locally

```bash
git clone https://github.com/rahat-codes/nova_fintech.git
cd nova_fintech
flutter pub get
flutter analyze
flutter run
```

## Quality Checks

Run the analyzer and automated tests before submitting changes:

```bash
flutter analyze
flutter test
```

## Roadmap

- [ ] Add screenshots and a short demo recording.
- [ ] Document the main user flows and screen architecture.
- [ ] Add unit and widget tests for core flows.
- [ ] Add secure authentication and backend integration if the project scope expands.
- [ ] Add clear demo data and transaction-state explanations.

## Disclaimer

This repository is a software-development portfolio project. Any balances, cards, transactions, or financial information shown in the app should be treated as demonstration data only.

## Author

**Rahat** · [GitHub](https://github.com/rahat-codes)
