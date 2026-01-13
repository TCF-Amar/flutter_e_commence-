import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_commerce/core/routes/app_router.dart';
import 'package:flutter_commerce/core/routes/auth_notifier.dart';
import 'package:flutter_commerce/core/storage/app_storage.dart';
import 'package:flutter_commerce/core/widgets/app_snackbar.dart';
import 'package:get/get.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:flutter_commerce/core/DI/dependency_injection.dart";

void main() async {
  //! Ensure Flutter engine is fully initialized
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //* Load environment variables first
  if (kIsWeb) {
    await dotenv.load(fileName: ".env.production");
  } else {
    await dotenv.load(fileName: ".env.development");
  }

  //* Initialize storage and load saved data
  final storage = AppStorage();
  await storage.init(); //? Load data from SharedPreferences
  Get.put(storage); //? Register with GetX

  final authNotifier = AuthNotifier(storage);

  //* Initialize DependenciesInjection
  DependenciesInjection.init();

  //* Run the app
  runApp(App(storage: storage, authNotifier: authNotifier));
}

class App extends StatelessWidget {
  final AppStorage storage;
  final AuthNotifier authNotifier;

  App({super.key, required this.storage, required this.authNotifier});

  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: AppSnackbar.messengerKey,
      //? Router Configuration
      routerConfig: AppRouter.router(
        storage: storage,
        authNotifier: authNotifier,
      ),
    );
  }
}
