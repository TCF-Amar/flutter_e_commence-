import 'package:flutter_commerce/core/routes/auth_notifier.dart';
import 'package:flutter_commerce/core/storage/app_storage.dart';
import 'package:flutter_commerce/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_commerce/features/dashboard/pages/dashboard_screen.dart';
import 'package:flutter_commerce/features/product/presentation/pages/category_screen.dart';
import 'package:flutter_commerce/features/product/presentation/pages/collection_screen.dart';
import 'package:flutter_commerce/features/product/presentation/pages/product_details_screen.dart';
import 'package:flutter_commerce/features/product/presentation/pages/search_screen.dart';
import 'package:flutter_commerce/features/settings/presentation/pages/settings_screen.dart';
import 'package:flutter_commerce/features/splash/pages/splash_screen.dart';
import './app_routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router({
    required AppStorage storage,
    required AuthNotifier authNotifier,
  }) {
    final initialLocation = AppRoutes.splash.path;

    return GoRouter(
      initialLocation: initialLocation,

      refreshListenable: authNotifier,

      redirect: (context, state) {
        final isLoggedIn = storage.isLoggedIn.value;
        final hasToken =
            storage.accessToken.value.isNotEmpty &&
            storage.refreshToken.value.isNotEmpty;
        final goingToLogin = state.matchedLocation == '/login';
        final goingToSplash = state.matchedLocation == '/splash';

        // Allow splash screen to show
        if (goingToSplash) {
          return null;
        }

        if (!isLoggedIn || !hasToken) {
          return goingToLogin ? null : AppRoutes.login.path;
        }

        if (goingToLogin) {
          return AppRoutes.dashboard.path;
        }

        return null;
      },

      routes: [
        GoRoute(
          name: AppRoutes.splash.name,
          path: AppRoutes.splash.path,
          builder: (context, state) {
            return const SplashScreen();
          },
        ),
        GoRoute(
          name: AppRoutes.login.name,
          path: AppRoutes.login.path,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          name: AppRoutes.dashboard.name,
          path: AppRoutes.dashboard.path,
          builder: (context, state) {
            return const DashboardScreen();
          },
        ),
        GoRoute(
          name: AppRoutes.catagory.name,
          path: AppRoutes.catagory.path,
          builder: (context, state) {
            // HomeDI().dependencies();
            return CategoryScreen(
              category: state.uri.queryParameters['category'] ?? "",
            );
          },
        ),
        GoRoute(
          name: AppRoutes.collection.name,
          path: AppRoutes.collection.path,
          builder: (context, state) {
            return const CollectionScreen();
          },
        ),
        GoRoute(
          name: AppRoutes.product.name,
          path: AppRoutes.product.path,
          builder: (context, state) {
            return ProductDetails(id: state.uri.queryParameters['id'] ?? "");
          },
        ),
        // GoRoute(
        //   name: AppRoutes.cart.name,
        //   path: AppRoutes.cart.path,
        //   builder: (context, state) {
        //     return const CartScreen();
        //   },
        // ),
        // GoRoute(
        //   name: AppRoutes.checkout.name,
        //   path: AppRoutes.checkout.path,
        //   builder: (context, state) {
        //     return const CheckoutScreen();
        //   },
        // ),
        // GoRoute(
        //   name: AppRoutes.orders.name,
        //   path: AppRoutes.orders.path,
        //   builder: (context, state) {
        //     return const OrdersScreen();
        //   },
        // ),
        // GoRoute(
        //   name: AppRoutes.profile.name,
        //   path: AppRoutes.profile.path,
        //   builder: (context, state) {
        //     return const ProfileScreen();
        //   },
        // ),
        GoRoute(
          name: AppRoutes.settings.name,
          path: AppRoutes.settings.path,
          builder: (context, state) {
            return const SettingsScreen();
          },
        ),
        // GoRoute(
        //   name: AppRoutes.wishlist.name,
        //   path: AppRoutes.wishlist.path,
        //   builder: (context, state) {
        //     return const WishlistScreen();
        //   },
        // ),
        GoRoute(
          name: AppRoutes.search.name,
          path: AppRoutes.search.path,
          builder: (context, state) {
            return const SearchScreen();
          },
        ),
      ],
    );
  }
}
