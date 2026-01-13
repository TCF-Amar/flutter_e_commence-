import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/auth/domain/entities/auth_token.dart';
import 'package:flutter_commerce/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase(this.authRepository);

  Future<Either<Failure, AuthToken>> login(String username, String password) {
    return authRepository.login(username, password);
  }
}
