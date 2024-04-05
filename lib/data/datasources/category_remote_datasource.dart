import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shopease_app/data/models/response/category_response_model.dart';

import '../../core/constants/variables.dart';

class CategoryRemoteDatasource {
  Future<Either<String, CategoryResponseModel>> getCategories() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/categories'),
      headers: headers,
    );

    log('Response Get Categories : ${response.body}');

    if (response.statusCode == 200) {
      return Right(CategoryResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }
}