import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/storage/storage_keys.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

///* A controller responsible for managing local storage and application state.
class AppStorage extends GetxController {
  ///* Instance of SharedPreferences for persistent storage.
  SharedPreferences? pref;

  ///* Reactive boolean indicating if the user is currently logged in.
  final isLoggedIn = false.obs;

  ///* Reactive string storing the current authentication token.
  final token = ''.obs;

  ///* Reactive ThemeMode storing the user's preferred theme setting.
  final themeMode = ThemeMode.system.obs;

  ///* Initializes the storage instance and loads saved values into reactive variables.
  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
    isLoggedIn.value = pref?.getBool(StorageKeys.isLoggedIn) ?? false;
    token.value = pref?.getString(StorageKeys.token) ?? '';
    themeMode.value = ThemeMode.values.firstWhere(
      (e) => e.name == pref?.getString(StorageKeys.themeMode),
      orElse: () => ThemeMode.system,
    );
  }

  ///* Updates the login status and persists it to local storage.
  void setIsLoggedIn(bool value) {
    isLoggedIn.value = value;
    pref?.setBool(StorageKeys.isLoggedIn, value);
  }

  ///* Updates the authentication token and persists it to local storage.
  void setToken(String value) {
    token.value = value;
    pref?.setString(StorageKeys.token, value);
  }

  ///* Updates the application theme mode and persists it to local storage.
  void setThemeMode(ThemeMode value) {
    themeMode.value = value;
    pref?.setString(StorageKeys.themeMode, value.name);
  }

  ///* Clears all stored data and resets reactive variables to their default values.
  void clear() {
    isLoggedIn.value = false;
    token.value = '';
    themeMode.value = ThemeMode.system;
    pref?.clear();
  }
}
