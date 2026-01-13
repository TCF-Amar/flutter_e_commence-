import 'package:jwt_decoder/jwt_decoder.dart';

class Jwt {
  static Map<String, dynamic>? decodeToken(String token) {
    try {
      return JwtDecoder.decode(token);
    } catch (e) {
      return null;
    }
  }

  static bool isExpired(String token) {
    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      // If token is invalid or malformed, consider it expired
      return false;
    }
  }
}
