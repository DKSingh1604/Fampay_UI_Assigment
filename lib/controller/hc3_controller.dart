import 'package:fampay_assignment/core/storage_service.dart';
import 'package:get/get.dart';

class HC3 extends GetxController {
  final RxSet<String> hiddenCards = <String>{}.obs;
  final RxSet<String> dismissedCards = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadCardStates();
  }

  void loadCardStates() async {
    try {
      final hidden = await StorageService.getHiddenCards();
      final dismissed = await StorageService.getDismissedCards();

      hiddenCards.clear();
      dismissedCards.clear();

      hiddenCards.addAll(hidden);
      dismissedCards.addAll(dismissed);
      update();
    } catch (e) {
      // If there's an error loading from storage, start with empty sets
      hiddenCards.clear();
      dismissedCards.clear();
    }
  }

  bool isCardVisible(String cardId) {
    return !hiddenCards.contains(cardId) && !dismissedCards.contains(cardId);
  }

  bool isCardHidden(String cardId) {
    return hiddenCards.contains(cardId);
  }

  bool isCardDismissed(String cardId) {
    return dismissedCards.contains(cardId);
  }

  Future<void> remindLater(String cardId) async {
    // Update UI immediately
    hiddenCards.add(cardId);
    update();

    // Persist to storage
    try {
      await StorageService.hideCard(cardId);
    } catch (e) {
      print('Error saving to storage: $e');
    }
  }

  Future<void> dismissNow(String cardId) async {
    // Update UI immediately
    dismissedCards.add(cardId);
    update();

    // Persist to storage
    try {
      await StorageService.dismissCard(cardId);
    } catch (e) {
      print('Error saving to storage: $e');
    }
  }

  Future<void> showCard(String cardId) async {
    hiddenCards.remove(cardId);
    dismissedCards.remove(cardId);
    await StorageService.unhideCard(cardId);
    await StorageService.undismissCard(cardId);
    update();
  }

  // Legacy method for backward compatibility
  void hideCard(String cardId) {
    remindLater(cardId);
  }
}
