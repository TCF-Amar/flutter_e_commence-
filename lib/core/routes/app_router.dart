import 'package:flutter_commerce/core/routes/auth_notifier.dart';
import 'package:flutter_commerce/core/storage/app_storage.dart';
import 'package:flutter_commerce/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_commerce/features/home/presentation/screens/home_page.dart';
import './app_routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router({
    required AppStorage storage,
    required AuthNotifier authNotifier,
  }) {
    final initialLocation = AppRoutes.login.path;

    return GoRouter(
      initialLocation: initialLocation,

      refreshListenable: authNotifier,

      redirect: (context, state) {
        final isLoggedIn = storage.isLoggedIn.value;
        final hasToken = storage.token.value.isNotEmpty;
        final goingToLogin = state.matchedLocation == '/login';

        if (!isLoggedIn || !hasToken) {
          return goingToLogin ? null : AppRoutes.login.path;
        }

        if (goingToLogin) {
          return AppRoutes.home.path;
        }

        return null;
      },

      routes: [
        GoRoute(
          name: AppRoutes.login.name,
          path: AppRoutes.login.path,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),

        GoRoute(
          name: AppRoutes.home.name,
          path: AppRoutes.home.path,
          builder: (context, state) {
            // HomeDI().dependencies();
            return HomeScreen();
          },
        ),
      ],
    );
  }
}
