import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shopease_app/core/constants/variables.dart';
import 'package:shopease_app/data/models/response/city_response_model.dart';
import 'package:shopease_app/data/models/response/province_response_model.dart';
import 'package:shopease_app/data/models/response/subdistrict_response_model.dart';

class RajaongkirRemoteDatasource {
  Future<Either<String, ProvinceResponseModel>> getProvince() async {
    final headers = {
      'key': Variables.rajaongkirApiKey,
    };
    final response = await http.get(
      Uri.parse('https://pro.rajaongkir.com/api/province'),
      headers: headers,
    );

    log('Response Province : ${response.body}');

    if (response.statusCode == 200) {
      return Right(ProvinceResponseModel.fromJson(response.body));
    } else {
      final errorMessage =
          jsonDecode(response.body)['rajaongkir']['status']['description'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, CityResponseModel>> getCity(String provinceId) async {
    final headers = {
      'key': Variables.rajaongkirApiKey,
    };
    final response = await http.get(
      Uri.parse('https://pro.rajaongkir.com/api/city?province=$provinceId'),
      headers: headers,
    );

    log('Response City : ${response.body}');

    if (response.statusCode == 200) {
      return Right(CityResponseModel.fromJson(response.body));
    } else {
      final errorMessage =
          jsonDecode(response.body)['rajaongkir']['status']['description'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, SubdistrictResponseModel>> getSubdistrict(
      String cityId) async {
    final headers = {
      'key': Variables.rajaongkirApiKey,
    };
    final response = await http.get(
      Uri.parse('https://pro.rajaongkir.com/api/subdistrict?city=$cityId'),
      headers: headers,
    );

    log('Response Subdistrict : ${response.body}');

    if (response.statusCode == 200) {
      return Right(SubdistrictResponseModel.fromJson(response.body));
    } else {
      final errorMessage =
          jsonDecode(response.body)['rajaongkir']['status']['description'];
      return Left(errorMessage);
    }
  }
}
