import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? "";
}
