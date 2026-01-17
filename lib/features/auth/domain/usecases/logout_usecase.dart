import 'package:flutter_commerce/features/auth/domain/repositories/auth_repository.dart';

/// Use case for user logout
class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  // /// Execute logout
  // Future<Either<Failure, void>> call() async {
  //   return await repository.logout();
  // }
}
