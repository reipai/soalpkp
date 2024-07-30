import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../database/db_helper.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final response = await _dio.get('https://api.restful-api.dev/objects');
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data = (response.data as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();

        await dbHelper.insertLog(response.toString());
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return [];
    }
  }
}