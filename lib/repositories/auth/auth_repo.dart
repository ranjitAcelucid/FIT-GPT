import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:sales/core/errors/failures.dart';
import 'package:sales/core/network/api_endpopints.dart';
import 'package:sales/core/network/api_service.dart';
import 'package:sales/core/network/error_handler.dart';
import 'package:sales/core/network/network_info.dart';
import 'package:sales/models/auth/login_model.dart';
import 'package:sales/utils/constants/status_code.dart';
import 'package:sales/utils/services/local_storage.dart';

class AuthRepository {
  final ApiService apiServcie;
  final NetworkInfo networkInfo;
  final MySharedPref mySharedPref;

  AuthRepository(
      {required this.apiServcie,
      required this.networkInfo,
      required this.mySharedPref});

// login repo
  Future<Either<Failure, LoginModel>> login(
      Map<String, dynamic> params, bool rememberMe) async {
    String email = params['email'];
    String password = params['password'];
    if (await networkInfo.isConnected) {
      try {
        final response = await apiServcie.post(
            endPoint: APIEndPoints.login,
            data: jsonEncode(params),
            useToken: false);
        LoginModel loginModel = LoginModel.fromJson(response.data);
        if (loginModel.status == StatusCode.ok) {
          mySharedPref.saveAccessToken(loginModel.data!.token ?? "");
          mySharedPref.saveUserData(jsonEncode(loginModel));
        }
        if (rememberMe) {
          mySharedPref.saveUserEmail(email);
          mySharedPref.saveUserPassword(password);
        } else {
          mySharedPref.clearUserEmailPassword();
        }
        return Right(loginModel);
      } on DioException catch (error) {
        return Left(ServerFailure.fromException(error));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
