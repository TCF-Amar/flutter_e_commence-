/// Centralized API endpoints for the Flutter Commerce application
///
/// This class contains all API endpoint paths used throughout the app.
/// Using constants helps avoid typos and makes endpoint management easier.
class ApiEndpoints {
  ApiEndpoints._(); // Private constructor to prevent instantiation

  // ============================================================================
  // BASE PATHS
  // ============================================================================
  static const String _auth = '/auth';
  static const String _users = '/users';
  static const String _products = '/products';
  static const String _carts = '/carts';
  static const String _orders = '/orders';

  // ============================================================================
  // AUTHENTICATION ENDPOINTS
  // ============================================================================

  /// POST: Login with username and password
  /// Body: { "username": "string", "password": "string" }
  /// Returns: { "token": "string" }
  static const String login = '$_auth/login';

  /// POST: Register new user
  /// Body: { "email": "string", "username": "string", "password": "string", "name": { "firstname": "string", "lastname": "string" } }
  static const String register = '$_auth/register';

  /// POST: Refresh authentication token
  /// Body: { "refreshToken": "string" }
  static const String refreshToken = '$_auth/refresh';

  /// POST: Logout user
  static const String logout = '$_auth/logout';

  /// POST: Request password reset
  /// Body: { "email": "string" }
  static const String forgotPassword = '$_auth/forgot-password';

  /// POST: Reset password with token
  /// Body: { "token": "string", "password": "string" }
  static const String resetPassword = '$_auth/reset-password';

  // ============================================================================
  // USER ENDPOINTS
  // ============================================================================

  /// GET: Get all users (admin only)
  /// Query params: ?limit=10&sort=desc
  static const String users = _users;

  /// GET: Get single user by ID
  /// Path: /users/{id}
  static String userById(int id) => '$_users/$id';

  /// GET: Get current user profile
  static const String currentUser = '$_users/me';

  /// PUT: Update user by ID
  /// Path: /users/{id}
  /// Body: User object
  static String updateUser(int id) => '$_users/$id';

  /// DELETE: Delete user by ID
  /// Path: /users/{id}
  static String deleteUser(int id) => '$_users/$id';

  /// PATCH: Update user profile
  /// Body: Partial user object
  static const String updateProfile = '$_users/me';

  // ============================================================================
  // PRODUCT ENDPOINTS
  // ============================================================================

  /// GET: Get all products
  /// Query params: ?limit=10&sort=desc
  static const String products = _products;

  /// GET: Get single product by ID
  /// Path: /products/{id}
  static String productById(int id) => '$_products/$id';

  /// GET: Get products by category
  /// Path: /products/category/{category}
  static String productsByCategory(String category) =>
      '$_products/category/$category';

  /// GET: Get all product categories
  static const String categories = '$_products/categories';

  /// POST: Add new product (admin only)
  /// Body: Product object
  static const String addProduct = _products;

  /// PUT: Update product by ID (admin only)
  /// Path: /products/{id}
  /// Body: Product object
  static String updateProduct(int id) => '$_products/$id';

  /// DELETE: Delete product by ID (admin only)
  /// Path: /products/{id}
  static String deleteProduct(int id) => '$_products/$id';

  /// GET: Search products
  /// Query params: ?q=search_term
  static const String searchProducts = '$_products/search';

  // ============================================================================
  // CART ENDPOINTS
  // ============================================================================

  /// GET: Get all carts
  /// Query params: ?limit=10&sort=desc
  static const String carts = _carts;

  /// GET: Get single cart by ID
  /// Path: /carts/{id}
  static String cartById(int id) => '$_carts/$id';

  /// GET: Get user's cart
  /// Path: /carts/user/{userId}
  static String cartByUserId(int userId) => '$_carts/user/$userId';

  /// POST: Add new cart
  /// Body: Cart object
  static const String addCart = _carts;

  /// PUT: Update cart by ID
  /// Path: /carts/{id}
  /// Body: Cart object
  static String updateCart(int id) => '$_carts/$id';

  /// DELETE: Delete cart by ID
  /// Path: /carts/{id}
  static String deleteCart(int id) => '$_carts/$id';

  /// POST: Add item to cart
  /// Body: { "productId": int, "quantity": int }
  static const String addToCart = '$_carts/add';

  /// DELETE: Remove item from cart
  /// Path: /carts/remove/{productId}
  static String removeFromCart(int productId) => '$_carts/remove/$productId';

  /// PUT: Update cart item quantity
  /// Path: /carts/update/{productId}
  /// Body: { "quantity": int }
  static String updateCartItem(int productId) => '$_carts/update/$productId';

  /// DELETE: Clear entire cart
  static const String clearCart = '$_carts/clear';

  // ============================================================================
  // ORDER ENDPOINTS
  // ============================================================================

  /// GET: Get all orders (admin only)
  /// Query params: ?limit=10&sort=desc
  static const String orders = _orders;

  /// GET: Get single order by ID
  /// Path: /orders/{id}
  static String orderById(int id) => '$_orders/$id';

  /// GET: Get user's orders
  /// Path: /orders/user/{userId}
  static String ordersByUserId(int userId) => '$_orders/user/$userId';

  /// POST: Create new order
  /// Body: Order object
  static const String createOrder = _orders;

  /// PUT: Update order status (admin only)
  /// Path: /orders/{id}
  /// Body: { "status": "string" }
  static String updateOrderStatus(int id) => '$_orders/$id';

  /// DELETE: Cancel order
  /// Path: /orders/{id}
  static String cancelOrder(int id) => '$_orders/$id';

  /// GET: Get order tracking
  /// Path: /orders/{id}/tracking
  static String orderTracking(int id) => '$_orders/$id/tracking';

  // ============================================================================
  // PAYMENT ENDPOINTS
  // ============================================================================

  /// POST: Process payment
  /// Body: Payment details
  static const String processPayment = '/payments/process';

  /// GET: Get payment methods
  static const String paymentMethods = '/payments/methods';

  /// POST: Add payment method
  /// Body: Payment method details
  static const String addPaymentMethod = '/payments/methods/add';

  /// DELETE: Remove payment method
  /// Path: /payments/methods/{id}
  static String removePaymentMethod(int id) => '/payments/methods/$id';

  // ============================================================================
  // WISHLIST ENDPOINTS
  // ============================================================================

  /// GET: Get user's wishlist
  static const String wishlist = '/wishlist';

  /// POST: Add item to wishlist
  /// Body: { "productId": int }
  static const String addToWishlist = '/wishlist/add';

  /// DELETE: Remove item from wishlist
  /// Path: /wishlist/remove/{productId}
  static String removeFromWishlist(int productId) =>
      '/wishlist/remove/$productId';

  /// DELETE: Clear wishlist
  static const String clearWishlist = '/wishlist/clear';

  // ============================================================================
  // REVIEW ENDPOINTS
  // ============================================================================

  /// GET: Get product reviews
  /// Path: /products/{productId}/reviews
  static String productReviews(int productId) =>
      '$_products/$productId/reviews';

  /// POST: Add product review
  /// Path: /products/{productId}/reviews
  /// Body: { "rating": int, "comment": "string" }
  static String addReview(int productId) => '$_products/$productId/reviews';

  /// PUT: Update review
  /// Path: /reviews/{reviewId}
  static String updateReview(int reviewId) => '/reviews/$reviewId';

  /// DELETE: Delete review
  /// Path: /reviews/{reviewId}
  static String deleteReview(int reviewId) => '/reviews/$reviewId';

  // ============================================================================
  // ADDRESS ENDPOINTS
  // ============================================================================

  /// GET: Get user's addresses
  static const String addresses = '/addresses';

  /// POST: Add new address
  /// Body: Address object
  static const String addAddress = '/addresses';

  /// PUT: Update address
  /// Path: /addresses/{id}
  static String updateAddress(int id) => '/addresses/$id';

  /// DELETE: Delete address
  /// Path: /addresses/{id}
  static String deleteAddress(int id) => '/addresses/$id';

  /// PUT: Set default address
  /// Path: /addresses/{id}/default
  static String setDefaultAddress(int id) => '/addresses/$id/default';

  // ============================================================================
  // NOTIFICATION ENDPOINTS
  // ============================================================================

  /// GET: Get user notifications
  static const String notifications = '/notifications';

  /// PUT: Mark notification as read
  /// Path: /notifications/{id}/read
  static String markNotificationRead(int id) => '/notifications/$id/read';

  /// PUT: Mark all notifications as read
  static const String markAllNotificationsRead = '/notifications/read-all';

  /// DELETE: Delete notification
  /// Path: /notifications/{id}
  static String deleteNotification(int id) => '/notifications/$id';

  /// DELETE: Clear all notifications
  static const String clearNotifications = '/notifications/clear';

  // ============================================================================
  // ANALYTICS ENDPOINTS
  // ============================================================================

  /// GET: Get user analytics
  static const String userAnalytics = '/analytics/user';

  /// GET: Get product analytics (admin only)
  static const String productAnalytics = '/analytics/products';

  /// GET: Get sales analytics (admin only)
  static const String salesAnalytics = '/analytics/sales';

  // ============================================================================
  // UPLOAD ENDPOINTS
  // ============================================================================

  /// POST: Upload image
  /// Body: FormData with image file
  static const String uploadImage = '/upload/image';

  /// POST: Upload multiple images
  /// Body: FormData with multiple image files
  static const String uploadImages = '/upload/images';

  /// POST: Upload document
  /// Body: FormData with document file
  static const String uploadDocument = '/upload/document';
}
