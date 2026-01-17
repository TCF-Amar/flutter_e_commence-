import 'package:flutter_commerce/core/error/failure.dart';
import 'package:flutter_commerce/core/utils/either.dart';
import 'package:flutter_commerce/features/auth/data/models/login_request_dto.dart';
import 'package:flutter_commerce/features/auth/data/models/login_response_dto.dart';
import 'package:flutter_commerce/features/auth/data/models/user_model.dart';

/// Abstract interface for auth remote data source
abstract class AuthRemoteDataSource {
  /// Login with credentials
  /// Returns Either with LoginResponseDto containing auth token or Failure
  Future<Either<Failure, LoginResponseDto>> login(LoginRequestDto request);

  /// Fetch user by ID
  /// Returns UserModel
  Future<UserModel> getLoginuser(String accessToken);
}
