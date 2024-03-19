import 'package:dio/dio.dart';

class ApiRepositories {
  final String apiURL = 'https://eightballapi.com/api';
  final dio = Dio();

  Future<String> getRandomString() async {
    final response = await dio.get(apiURL);
    Map<String, dynamic> data = response.data;
    return data['reading'] ?? 'Error. Try again';
  }
}