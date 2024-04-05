import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shopease_app/data/datasources/auth_local_datasource.dart';

import '../../core/constants/variables.dart';
import '../models/request/login_request_model.dart';
import '../models/request/register_request_model.dart';
import '../models/response/auth_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel registerRequest) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/register'),
      headers: headers,
      body: registerRequest.toJson(),
    );

    log('Request Register : ${registerRequest.toJson()}');
    log('Response Register : ${response.body}');

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel loginRequest) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      headers: headers,
      body: loginRequest.toJson(),
    );

    log('Request Login : ${loginRequest.toJson()}');
    log('Response Login : ${response.body}');

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, String>> logout() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: headers,
    );

    log('Response Logout : ${response.body}');

    if (response.statusCode == 200) {
      AuthLocalDatasource().removeAuthData();
      final successMessage = jsonDecode(response.body)['message'];
      return Right(successMessage);
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, String>> updateFcmToken(String fcmToken) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/fcm-token'),
      headers: headers,
      body: jsonEncode({
        'fcm_id': fcmToken,
      }),
    );

    if (response.statusCode == 200) {
      return const Right('Update fcm token');
    } else {
      return const Left('Update fcm token error');
    }
  }

  // Future<Either<String, UserResponseModel>> getUser() async {
  //   final token = await AuthLocalDatasource().getToken();
  //   final headers = {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   final response = await http.get(
  //     Uri.parse('${Variables.baseUrl}/api/user'),
  //     headers: headers,
  //   );

  //   debugPrint('Response Get User : ${response.body}');

  //   if (response.statusCode == 200) {
  //     return Right(UserResponseModel.fromJson(response.body));
  //   } else {
  //     final errorMessage = jsonDecode(response.body)['meta']['message'];
  //     return Left(errorMessage);
  //   }
  // }

  // Future<Either<String, UserResponseModel>> updateUser(UserRequestModel userRequest) async {
  //   final token = await AuthLocalDatasource().getToken();
  //   final headers = {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };

  //   final response = await http.post(
  //     Uri.parse('${Variables.baseUrl}/api/user'),
  //     headers: headers,
  //     body: userRequest.toJson(),
  //   );

  //   debugPrint('Response Update User : ${response.body}');

  //   if (response.statusCode == 200) {
  //     return Right(UserResponseModel.fromJson(response.body));
  //   } else {
  //     final errorMessage = jsonDecode(response.body)['meta']['message'];
  //     return Left(errorMessage);
  //   }
  // }
}
