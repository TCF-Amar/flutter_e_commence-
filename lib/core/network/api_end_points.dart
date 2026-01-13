class ApiEndpoints {
  ApiEndpoints._();

  static const String _auth = '/auth';
  static const String _users = '/users';
  static const String _products = '/products';
  // static const String _carts = '/carts';
  // static const String _orders = '/orders';

  static const String login = '$_auth/login';

  static const String register = '$_auth/register';

  static const String users = _users;

  static String userById(int id) => '$_users/$id';

  static const String products = _products;

  static String productById(int id) => '$_products/$id';

  static const String categories = '$_products/categories';

  static const String addProduct = _products;
}
