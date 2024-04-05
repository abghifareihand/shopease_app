import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shopease_app/data/models/request/address_request_model.dart';
import 'package:shopease_app/data/models/response/address_response_model.dart';

import '../../core/constants/variables.dart';

class AddressRemoteDatasource {
  Future<Either<String, AddressResponseModel>> getAddress() async {
    // final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 3|hvPrAptW32RpqN1ydJ6r0n3mZmT5IdhfShk3oeLZfad37a3e',
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/address'),
      headers: headers,
    );

    log('Response Get Address : ${response.body}');

    if (response.statusCode == 200) {
      return Right(AddressResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, String>> addAddress(
      AddressRequestModel addressRequest) async {
    // final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 3|hvPrAptW32RpqN1ydJ6r0n3mZmT5IdhfShk3oeLZfad37a3e',
    };
    final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/address'),
        headers: headers,
        body: addressRequest.toJson());

    log('Response Add Address : ${response.body}');

    if (response.statusCode == 201) {
      final successMessage = jsonDecode(response.body)['message'];
      return Right(successMessage);
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }
}