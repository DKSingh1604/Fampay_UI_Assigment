import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _hiddenCardsKey = 'hidden_cards';
  static const String _dismissedCardsKey = 'dismissed_cards';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception(
          'StorageService not initialized. Call StorageService.init() first.');
    }
    return _prefs!;
  }

  static Future<SharedPreferences> get prefsAsync async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
      return _prefs!;
    } catch (e) {
      print('Error initializing SharedPreferences: $e');
      // Return a mock prefs that doesn't save anything but doesn't crash
      throw Exception('SharedPreferences not available: $e');
    }
  }

  // Methods for hidden cards (remind later)
  static Future<void> hideCard(String cardId) async {
    try {
      final hiddenCards = await getHiddenCards();
      hiddenCards.add(cardId);
      final prefs = await prefsAsync;
      await prefs.setStringList(_hiddenCardsKey, hiddenCards.toList());
    } catch (e) {
      print('Error hiding card: $e');
    }
  }

  static Future<Set<String>> getHiddenCards() async {
    try {
      final prefs = await prefsAsync;
      final hiddenCardsList = prefs.getStringList(_hiddenCardsKey) ?? [];
      return Set<String>.from(hiddenCardsList);
    } catch (e) {
      print('Error getting hidden cards: $e');
      return <String>{};
    }
  }

  static Future<void> unhideCard(String cardId) async {
    try {
      final hiddenCards = await getHiddenCards();
      hiddenCards.remove(cardId);
      final prefs = await prefsAsync;
      await prefs.setStringList(_hiddenCardsKey, hiddenCards.toList());
    } catch (e) {
      print('Error unhiding card: $e');
    }
  }

  // Methods for dismissed cards (dismiss now)
  static Future<void> dismissCard(String cardId) async {
    try {
      final dismissedCards = await getDismissedCards();
      dismissedCards.add(cardId);
      final prefs = await prefsAsync;
      await prefs.setStringList(_dismissedCardsKey, dismissedCards.toList());
    } catch (e) {
      print('Error dismissing card: $e');
    }
  }

  static Future<Set<String>> getDismissedCards() async {
    final prefs = await prefsAsync;
    final dismissedCardsList = prefs.getStringList(_dismissedCardsKey) ?? [];
    return Set<String>.from(dismissedCardsList);
  }

  static Future<void> undismissCard(String cardId) async {
    final dismissedCards = await getDismissedCards();
    dismissedCards.remove(cardId);
    final prefs = await prefsAsync;
    await prefs.setStringList(_dismissedCardsKey, dismissedCards.toList());
  }

  // Check if card should be visible
  static Future<bool> isCardVisible(String cardId) async {
    final hiddenCards = await getHiddenCards();
    final dismissedCards = await getDismissedCards();
    return !hiddenCards.contains(cardId) && !dismissedCards.contains(cardId);
  }

  // Clear all hidden cards (for app restart - hidden cards should reappear)
  static Future<void> clearHiddenCards() async {
    final prefs = await prefsAsync;
    await prefs.remove(_hiddenCardsKey);
  }

  // Clear all data (for testing purposes)
  static Future<void> clearAllData() async {
    final prefs = await prefsAsync;
    await prefs.remove(_hiddenCardsKey);
    await prefs.remove(_dismissedCardsKey);
  }

  // Synchronous methods for immediate access (fallback)
  static Set<String> getHiddenCardsSync() {
    if (_prefs == null) return <String>{};
    final hiddenCardsList = _prefs!.getStringList(_hiddenCardsKey) ?? [];
    return Set<String>.from(hiddenCardsList);
  }

  static Set<String> getDismissedCardsSync() {
    if (_prefs == null) return <String>{};
    final dismissedCardsList = _prefs!.getStringList(_dismissedCardsKey) ?? [];
    return Set<String>.from(dismissedCardsList);
  }

  static bool isCardVisibleSync(String cardId) {
    final hiddenCards = getHiddenCardsSync();
    final dismissedCards = getDismissedCardsSync();
    return !hiddenCards.contains(cardId) && !dismissedCards.contains(cardId);
  }
}
