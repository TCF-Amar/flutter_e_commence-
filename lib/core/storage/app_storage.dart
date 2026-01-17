import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/storage/storage_keys.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

//* A controller responsible for managing local storage and application state.
class AppStorage extends GetxController {
  //* Instance of SharedPreferences for persistent storage.
  SharedPreferences? pref;

  //* Reactive boolean indicating if the user is currently logged in.
  final isLoggedIn = false.obs;

  //* Reactive string storing the current authentication token.
  final accessToken = ''.obs;

  //* Reactive string storing the current authentication token.
  final refreshToken = ''.obs;

  //* Reactive ThemeMode storing the user's preferred theme setting.
  final themeMode = ThemeMode.system.obs;

  //* Reactive List<String> storing recent searches.
  final recentSearches = <String>[].obs;

  //* Reactive List<String> storing wishlist.
  final wishlist = <String>[].obs;

  //* Initializes the storage instance and loads saved values into reactive variables.
  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
    isLoggedIn.value = pref?.getBool(StorageKeys.isLoggedIn) ?? false;
    accessToken.value = pref?.getString(StorageKeys.accessToken) ?? '';
    refreshToken.value = pref?.getString(StorageKeys.refreshToken) ?? '';
    themeMode.value = ThemeMode.values.firstWhere(
      (e) => e.name == pref?.getString(StorageKeys.themeMode),
      orElse: () => ThemeMode.system,
    );
    recentSearches.value =
        pref?.getStringList(StorageKeys.recentSearches) ?? [];
    wishlist.value = pref?.getStringList(StorageKeys.wishlist) ?? [];
  }

  //* Updates the login status and persists it to local storage.
  void setIsLoggedIn(bool value) {
    isLoggedIn.value = value;
    pref?.setBool(StorageKeys.isLoggedIn, value);
  }

  //* Updates the authentication token and persists it to local storage.
  void setToken(String accessToken, String refreshToken) {
    this.accessToken.value = accessToken;
    this.refreshToken.value = refreshToken;
    pref?.setString(StorageKeys.accessToken, accessToken);
    pref?.setString(StorageKeys.refreshToken, refreshToken);
  }

  //* Updates the application theme mode and persists it to local storage.
  void setThemeMode(ThemeMode value) {
    themeMode.value = value;
    pref?.setString(StorageKeys.themeMode, value.name);
  }

  //* Updates the recent searches and persists it to local storage.
  void setRecentSearches(List<String> searches) {
    recentSearches.value = searches;
    pref?.setStringList(StorageKeys.recentSearches, searches);
  }

  void setWishlist(List<String> productId) {
    wishlist.value = productId;
    pref?.setStringList(StorageKeys.wishlist, productId);
  }

  //* Clears all stored data and resets reactive variables to their default values.
  void clear() {
    isLoggedIn.value = false;
    accessToken.value = '';
    refreshToken.value = '';
    themeMode.value = ThemeMode.system;
    recentSearches.clear();
    wishlist.clear();
    pref?.clear();
  }
}
