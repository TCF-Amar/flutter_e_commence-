import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../storage/app_storage.dart';

class AuthNotifier extends ChangeNotifier {
  late final Worker _worker;
  final AppStorage storage;

  AuthNotifier(this.storage) {
    _worker = everAll([
      storage.isLoggedIn,
      storage.token,
    ], (_) => notifyListeners());
  }

  @override
  void dispose() {
    _worker.dispose();
    super.dispose();
  }
}
