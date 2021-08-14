import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';

class TypicodeService {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com/';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      }
    )
  );

  @optionalTypeArgs
  Future<T?> getData<T>(String path, {
    List<Interceptor>? interceptors,
    Map<String, dynamic>? queryParameters,
  }) async {

    if (interceptors != null) {
      if (interceptors.isNotEmpty) {
        interceptors.forEach((interceptor) {
          _dio.interceptors.add(interceptor);
        });
      }
    }

    try {
      final response = await _dio.get(path,
        queryParameters: queryParameters
      );
      return response.data;
    } on DioError catch (error) {
      print(error);
      return null;
    } finally {
      _dio.interceptors.clear();
    }
  }

  @optionalTypeArgs
  Future<T?> postData<T>(String path, {
    required dynamic data,
    List<Interceptor>? interceptors,
    Map<String, dynamic>? queryParameters,
  }) async {

    if (interceptors != null) {
      if (interceptors.isNotEmpty) {
        interceptors.forEach((interceptor) {
          _dio.interceptors.add(interceptor);
        });
      }
    }

    try {
      final response = await _dio.post(path,
        data: data,
      );
      return response.data;
    } on DioError catch (error) {
      print(error);
      return null;
    } finally {
      _dio.interceptors.clear();
    }
  }
}