class AppRoutes {
  AppRoutes._();

  static final RouteModel splash = RouteModel(name: 'splash', path: '/');
  static final RouteModel login = RouteModel(name: 'login', path: '/login');
  static final RouteModel home = RouteModel(name: 'home', path: '/home');
}

class RouteModel {
  final String name;
  final String path;
  RouteModel({required this.name, required this.path});
}
