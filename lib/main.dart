import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_commerce/core/controllers/theme_controller.dart';
import 'package:flutter_commerce/core/routes/app_router.dart';
import 'package:flutter_commerce/core/routes/auth_notifier.dart';
import 'package:flutter_commerce/core/storage/app_storage.dart';
import 'package:flutter_commerce/core/theme/app_theme.dart';
import 'package:flutter_commerce/core/widgets/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:flutter_commerce/core/DI/di.dart";

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
  AppDI.init();

  //* Run the app
  runApp(App(storage: storage, authNotifier: authNotifier));
}

class App extends StatefulWidget {
  final AppStorage storage;
  final AuthNotifier authNotifier;

  const App({super.key, required this.storage, required this.authNotifier});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppRouter appRouter = AppRouter();
  late final ThemeController themeController;
  late final GoRouter router;

  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeController>();
    router = AppRouter.router(
      storage: widget.storage,
      authNotifier: widget.authNotifier,
    );

    // Listen to theme changes and rebuild
    themeController.themeMode.listen((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: AppSnackbar.messengerKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeController.themeMode.value,
      routerConfig: router,
    );
  }
}
