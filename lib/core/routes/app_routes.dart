class AppRoutes {
  AppRoutes._();

  static final RouteModel splash = RouteModel(name: 'splash', path: '/splash');
  static final RouteModel dashboard = RouteModel(
    name: 'dashboard',
    path: '/dashboard',
  );
  static final RouteModel login = RouteModel(name: 'login', path: '/login');
  static final RouteModel home = RouteModel(name: 'home', path: '/home');
  static final RouteModel product = RouteModel(
    name: 'product',
    path: '/product',
  );
  static final RouteModel productDetails = RouteModel(
    name: 'productDetails',
    path: '/productDetails',
  );
  static final RouteModel cart = RouteModel(name: 'cart', path: '/cart');
  static final RouteModel checkout = RouteModel(
    name: 'checkout',
    path: '/checkout',
  );
  static final RouteModel orders = RouteModel(name: 'orders', path: '/orders');
  static final RouteModel profile = RouteModel(
    name: 'profile',
    path: '/profile',
  );
  static final RouteModel settings = RouteModel(
    name: 'settings',
    path: '/settings',
  );
  static final RouteModel wishlist = RouteModel(
    name: 'wishlist',
    path: '/wishlist',
  );
  static final RouteModel catagory = RouteModel(
    name: 'catagory',
    path: '/catagory',
  );
  static final RouteModel search = RouteModel(name: 'search', path: '/search');
}

class RouteModel {
  final String name;
  final String path;
  RouteModel({required this.name, required this.path});
}
