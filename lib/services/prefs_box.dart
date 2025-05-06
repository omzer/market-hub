import 'package:get_storage/get_storage.dart';

class PrefsBox {
  static final GetStorage _box = GetStorage();

  static GetStorage get instance => _box;

  // Initialize GetStorage
  static Future<void> initStorage() async {
    await GetStorage.init();
  }

  // constants
  static const String _tutorialCompletedKey = 'tutorial_completed';
  static const String _favoriteProductIdsKey = 'favorite_product_ids';

  static bool isTutorialCompleted() {
    return _box.read<bool>(_tutorialCompletedKey) ?? false;
  }

  static Future<void> setTutorialCompleted() async {
    await _box.write(_tutorialCompletedKey, true);
  }

  static List<String> getFavoriteProductIds() {
    return _box.read<List<dynamic>>(_favoriteProductIdsKey)?.cast<String>() ??
        [];
  }

  static Future<void> setFavoriteProductIds(List<String> productIds) async {
    await _box.write(_favoriteProductIdsKey, productIds);
  }

  static Future<void> addFavoriteProductId(String productId) async {
    final List<String> favoriteIds = getFavoriteProductIds();
    if (!favoriteIds.contains(productId)) {
      favoriteIds.add(productId);
      await setFavoriteProductIds(favoriteIds);
    }
  }

  static Future<void> removeFavoriteProductId(String productId) async {
    final List<String> favoriteIds = getFavoriteProductIds();
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
      await setFavoriteProductIds(favoriteIds);
    }
  }
}
