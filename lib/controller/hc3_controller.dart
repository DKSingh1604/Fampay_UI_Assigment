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
    hiddenCards.add(cardId);
    update();

    try {
      await StorageService.hideCard(cardId);
    } catch (e) {
      print('Error saving to storage: $e');
    }
  }

  Future<void> dismissNow(String cardId) async {
    dismissedCards.add(cardId);
    update();

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

  void hideCard(String cardId) {
    remindLater(cardId);
  }
}
