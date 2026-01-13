import 'package:flutter_commerce/core/network/dio_helper.dart';
import 'package:flutter_commerce/features/auth/data/models/login_request_model.dart';
import 'package:flutter_commerce/features/auth/data/models/login_response_model.dart';

class AuthRemoteDatasource {
  final DioHelper dio;

  AuthRemoteDatasource(this.dio);

  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    final response = await dio.get(
      '/login',
      queryParameters: loginRequestModel.toJson(),
    );
    return LoginResponseModel.fromJson(response.data);
  }
}
