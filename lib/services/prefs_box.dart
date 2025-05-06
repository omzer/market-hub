import 'package:get_storage/get_storage.dart';

class PrefsBox {
  static final GetStorage _box = GetStorage();

  // Initialize GetStorage
  static Future<void> initStorage() async {
    await GetStorage.init();
  }

  // constants
  static const String _tutorialCompletedKey = 'tutorial_completed';

  static bool isTutorialCompleted() {
    return _box.read<bool>(_tutorialCompletedKey) ?? false;
  }

  static Future<void> setTutorialCompleted() async {
    await _box.write(_tutorialCompletedKey, true);
  }
}
