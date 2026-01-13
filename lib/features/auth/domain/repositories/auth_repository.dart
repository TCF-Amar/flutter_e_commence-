import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/auth/domain/entities/auth_token.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthToken>> login(String username, String password);
}
