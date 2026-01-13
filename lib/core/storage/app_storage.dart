import 'package:flutter_commerce/core/storage/storage_keys.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage extends GetxController {
  SharedPreferences? pref;

  final isLoggedIn = false.obs;
  final token = ''.obs;

  /// Initialize storage by loading data from SharedPreferences
  /// This should be called before the app starts
  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
    isLoggedIn.value = pref?.getBool(StorageKeys.isLoggedIn) ?? false;
    token.value = pref?.getString(StorageKeys.token) ?? '';
  }

  // @override 
  // void onReady() {
  //   super.onReady();
  //   // Data is already loaded in init()
  // }

  void setIsLoggedIn(bool value) {
    isLoggedIn.value = value;
    pref?.setBool(StorageKeys.isLoggedIn, value);
  }

  void setToken(String value) {
    token.value = value;
    pref?.setString(StorageKeys.token, value);
  }

  void clear() {
    isLoggedIn.value = false;
    token.value = '';
    pref?.clear();
  }
}
