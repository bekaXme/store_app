import 'package:dio/dio.dart';
import 'package:store_app/core/result/result.dart';
import '../interceptor/auth_interceptor.dart';

class ApiClient {
  final AuthInterceptor interceptor;

  ApiClient({required this.interceptor}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.8.47:8888/api/v1",
      ),
    )..interceptors.add(interceptor);
  }

  late final Dio _dio;

  Future<Result<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        return Result.success(response.data as T);
      } else {
        return Result.error(
          Exception(
            'Failed to get data: ${response.statusCode} - ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Result.error(Exception('Network error: ${e.message}'));
    } catch (e) {
      return Result.error(Exception('Unexpected error: $e'));
    }
  }

  Future<Result<T>> post<T>(String path,
      {required Map<String, dynamic> data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(path, data: data, queryParameters: queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Result.success(response.data as T);
      } else {
        return Result.error(Exception('Failed to post data: ${response.statusCode} - ${response.data}'));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        return Result.error(Exception('Request timed out. Please check your network connection.'));
      }
      return Result.error(Exception('Network error: ${e.message}'));
    } catch (e) {
      return Result.error(Exception('Unexpected error: $e'));
    }
  }

  Future<Result<T>> delete<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.delete(path, queryParameters: queryParameters);
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Some delete APIs return no body, so cast carefully
        return Result.success(
          response.data != null ? response.data as T : null as T,
        );
      } else {
        return Result.error(
          Exception(
            'Failed to delete: ${response.statusCode} - ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return Result.error(
            Exception('Request timed out. Please check your network connection.'));
      }
      return Result.error(Exception('Network error: ${e.message}'));
    } catch (e) {
      return Result.error(Exception('Unexpected error: $e'));
    }
  }
}
