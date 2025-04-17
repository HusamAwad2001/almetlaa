import '../utils/api_error_handler.dart';
import '../utils/api_error_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../values/constants.dart';
import '../core/global.dart';

bool noInternet = false;

const int _requestTimeout = 30;

class API {
  String baseURL = Constants.baseURL;

  Dio get _dio {
    return Dio(
      BaseOptions(
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Global.token}"
        },
        sendTimeout: const Duration(seconds: _requestTimeout),
        receiveTimeout: const Duration(seconds: _requestTimeout),
        connectTimeout: const Duration(seconds: _requestTimeout),
      ),
    )..interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ));
  }

  Future<void> get({
    String? baseURL,
    required String url,
    required Function(ApiResponse response) onResponse,
    Function(ApiErrorModel errorModel)? onError,
    Map<String, dynamic>? queryParameters,
  }) async {
    noInternet = false;
    try {
      var response = await _dio.get(
        "${baseURL ?? this.baseURL}$url",
        queryParameters: queryParameters,
      );
      ApiResponse apiResponse = ApiResponse(
        statusCode: response.statusCode ?? 0,
        success: response.data['success'],
        pagination: response.data['pagination'] != null
            ? PaginationModel.fromJson(response.data['pagination'])
            : null,
        data: response.data,
      );
      onResponse(apiResponse);
    } catch (e) {
      if (onError != null) {
        ServerException exception = ApiErrorHandler.handle(e);
        onError(exception.apiErrorModel);
      }
    }
  }

  Future<void> post({
    required String url,
    required var body,
    required Function(ApiResponse response) onResponse,
    Function(ApiErrorModel errorModel)? onError,
  }) async {
    noInternet = false;
    try {
      var response = await _dio.post("$baseURL$url", data: body);
      ApiResponse apiResponse = ApiResponse(
        statusCode: response.statusCode ?? 0,
        success: response.data['success'],
        pagination: response.data['pagination'] != null
            ? PaginationModel.fromJson(response.data['pagination'])
            : null,
        data: response.data,
      );
      onResponse(apiResponse);
    } catch (e) {
      if (onError != null) {
        ServerException exception = ApiErrorHandler.handle(e);
        onError(exception.apiErrorModel);
      }
    }
  }

  Future<void> put({
    required String url,
    required var body,
    required Function(ApiResponse response) onResponse,
    Function(ApiErrorModel errorModel)? onError,
  }) async {
    noInternet = false;
    try {
      var response = await _dio.put("$baseURL$url", data: body);
      ApiResponse apiResponse = ApiResponse(
        statusCode: response.statusCode ?? 0,
        success: response.data['success'],
        pagination: response.data['pagination'] != null
            ? PaginationModel.fromJson(response.data['pagination'])
            : null,
        data: response.data,
      );
      onResponse(apiResponse);
    } catch (e) {
      if (onError != null) {
        ServerException exception = ApiErrorHandler.handle(e);
        onError(exception.apiErrorModel);
      }
    }
  }

  Future<void> delete({
    required String url,
    required var body,
    required Function(ApiResponse response) onResponse,
    Function(ApiErrorModel errorModel)? onError,
  }) async {
    noInternet = false;
    try {
      var response = await _dio.delete("$baseURL$url", data: body);
      ApiResponse apiResponse = ApiResponse(
        statusCode: response.statusCode ?? 0,
        success: response.data['success'],
        pagination: response.data['pagination'] != null
            ? PaginationModel.fromJson(response.data['pagination'])
            : null,
        data: response.data,
      );
      onResponse(apiResponse);
    } catch (e) {
      if (onError != null) {
        ServerException exception = ApiErrorHandler.handle(e);
        onError(exception.apiErrorModel);
      }
    }
  }
}

class ApiResponse {
  late int statusCode;
  late bool success;
  PaginationModel? pagination;
  late Map data;

  ApiResponse({
    required this.statusCode,
    required this.success,
    this.pagination,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      statusCode: 0,
      success: json['success'],
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : null,
      data: json['data'],
    );
  }
}

class PaginationModel {
  int? current;
  int? limit;
  int? pages;
  int? total;
  int? maxDocuments;

  PaginationModel({
    this.current,
    this.limit,
    this.pages,
    this.total,
    this.maxDocuments,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      current: json['current'],
      limit: json['limit'],
      pages: json['pages'],
      total: json['total'],
      maxDocuments: json['maxDocuments'],
    );
  }
}
