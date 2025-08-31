# FamPay Flutter Assignment

A Flutter app implementing FamPay's contextual cards with persistent storage, deep linking, and offline support.

## What's Built

This app displays contextual cards from FamPay's API with these features:

- **All Card Types**: HC1 (small cards), HC3 (big cards with actions), HC5 (image cards), HC6 (navigation cards), HC9 (gradient cards)
- **Smart Interactions**: Tap cards to open deep links, long-press HC3 cards for "Remind Later" or "Dismiss Now" options
- **Offline Ready**: Shows demo data when network fails, with clear offline indicators
- **Pull to Refresh**: Swipe down to reload data
- **Persistent Memory**: Cards remember their hidden/dismissed state between app sessions

## App Demo

https://github.com/user-attachments/assets/c69224bc-eba3-4ea1-9303-096b0d74aeb0

*Watch the app in action showing all card types, interactions, and features*

## Tech Stack

- **Flutter 3.5.4+** with GetX for state management
- **HTTP** for API calls with 10s timeout
- **SharedPreferences** for local storage
- **URL Launcher** for deep links
- **Flutter SVG** for assets

## Quick Start

```bash
git clone <repo-url>
cd Fampay-Assignment-master
flutter pub get
flutter run
```

For APK: `flutter build apk --release`

## How It Works

The app fetches cards from FamPay's API and renders them based on their type. When you long-press HC3 cards, action buttons slide out. "Remind Later" hides cards until next app launch, while "Dismiss Now" removes them permanently.

If the network fails, the app automatically switches to offline mode with sample cards, so you can still see how everything works.

## Key Files

- `lib/controller/card_controller.dart` - API calls and error handling
- `lib/controller/hc3_controller.dart` - Card interaction logic  
- `lib/core/storage_service.dart` - Persistent storage
- `lib/widget/hc/` - Card type implementations
- `lib/page/home_page.dart` - Main screen

## Testing

The app handles various scenarios:
- Network timeouts and failures
- API unavailability with graceful fallbacks
- Card state persistence across restarts
- Deep link navigation to external URLs

Built with attention to real-world usage patterns and error scenarios.