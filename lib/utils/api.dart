import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../routes/routes.dart';
import '../values/constants.dart';
import '../core/global.dart';

bool noInternet = false;

class API {
  String baseURL = Constants.baseURL;

  Dio _dio() {
    return Dio(
      BaseOptions(
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Global.token}"
        },
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
    required Function(ApiResponse) onResponse,
    Map<String, dynamic>? queryParameters,
  }) async {
    noInternet = false;
    try {
      var response = await _dio().get(
        "${baseURL ?? this.baseURL}$url",
        queryParameters: queryParameters,
      );
      ApiResponse apiResponse = ApiResponse(
          statusCode: response.statusCode ?? 0,
          message: handleMessage(response.statusCode ?? 0),
          data: response.data);
      onResponse(apiResponse);
    } on DioException catch (e) {
      onError(e, onResponse);
    }
  }

  onError(var e, Function(ApiResponse) onResponse) {
    int statusCode = e.response?.statusCode ?? 0;
    if (statusCode == 0) {
      if (!noInternet) {
        noInternet = true;
        Get.offAllNamed(Routes.internetPage);
      }
    } else {
      ApiResponse apiResponse = ApiResponse(
          statusCode: e.response?.statusCode ?? 0,
          message: handleMessage(e.response?.statusCode ?? 0),
          data: e.response?.data ?? {});
      onResponse(apiResponse);
    }
  }

  void post(
      {required String url,
      required var body,
      required Function(ApiResponse) onResponse}) async {
    noInternet = false;
    try {
      var response = await _dio().post("$baseURL$url", data: body);
      ApiResponse apiResponse = ApiResponse(
          statusCode: response.statusCode ?? 0,
          message: handleMessage(response.statusCode ?? 0),
          data: response.data);
      onResponse(apiResponse);
    } on DioException catch (e) {
      onError(e, onResponse);
    }
  }

  void put(
      {required String url,
      required var body,
      required Function(ApiResponse) onResponse}) async {
    noInternet = false;
    try {
      var response = await _dio().put("$baseURL$url", data: body);
      ApiResponse apiResponse = ApiResponse(
          statusCode: response.statusCode ?? 0,
          message: handleMessage(response.statusCode ?? 0),
          data: response.data);
      onResponse(apiResponse);
    } on DioException catch (e) {
      onError(e, onResponse);
    }
  }

  void delete(
      {required String url,
      required var body,
      required Function(ApiResponse) onResponse}) async {
    noInternet = false;
    try {
      var response = await _dio().delete("$baseURL$url", data: body);
      ApiResponse apiResponse = ApiResponse(
          statusCode: response.statusCode ?? 0,
          message: handleMessage(response.statusCode ?? 0),
          data: response.data);
      onResponse(apiResponse);
    } on DioException catch (e) {
      onError(e, onResponse);
    }
  }

  handleMessage(int statusCode) {
    late String message;

    statusCode == 200
        ? message = 'Ok'
        : statusCode == 201
            ? message = 'Created'
            : statusCode == 202
                ? message = 'Accepted'
                : statusCode == 203
                    ? message = 'Non-Authoritative Information'
                    : statusCode == 204
                        ? message = 'No Content'
                        : statusCode == 205
                            ? message = 'Reset Content'
                            : statusCode == 206
                                ? message = 'Partial Content'
                                : statusCode == 207
                                    ? message = 'Multi-Status'
                                    : statusCode == 208
                                        ? message = 'Already Reported'
                                        : statusCode == 226
                                            ? message = 'IM Used'
                                            : statusCode == 300
                                                ? message = 'Multiple Choices'
                                                : statusCode == 301
                                                    ? message =
                                                        'Moved Permanently'
                                                    : statusCode == 302
                                                        ? message = 'Found'
                                                        : statusCode == 303
                                                            ? message =
                                                                'Check Other'
                                                            : statusCode == 304
                                                                ? message =
                                                                    'Not Modified'
                                                                : statusCode ==
                                                                        305
                                                                    ? message =
                                                                        'Use Proxy'
                                                                    : statusCode ==
                                                                            306
                                                                        ? message =
                                                                            'Switch Proxy'
                                                                        : statusCode ==
                                                                                307
                                                                            ? message =
                                                                                'Temporary Redirect'
                                                                            : statusCode == 308
                                                                                ? message = 'Permanent Redirect'
                                                                                : statusCode == 400
                                                                                    ? message = 'Bad Request'
                                                                                    : statusCode == 401
                                                                                        ? message = 'Unauthorised'
                                                                                        : statusCode == 402
                                                                                            ? message = 'Payment Required'
                                                                                            : statusCode == 403
                                                                                                ? message = 'Forbidden'
                                                                                                : statusCode == 404
                                                                                                    ? message = 'Not Found'
                                                                                                    : statusCode == 405
                                                                                                        ? message = 'Method Not Allowed'
                                                                                                        : statusCode == 406
                                                                                                            ? message = 'Not Acceptable'
                                                                                                            : statusCode == 407
                                                                                                                ? message = 'Proxy Authentication Required'
                                                                                                                : statusCode == 408
                                                                                                                    ? message = 'Request Timeout'
                                                                                                                    : statusCode == 409
                                                                                                                        ? message = 'Conflict'
                                                                                                                        : statusCode == 410
                                                                                                                            ? message = 'Gone'
                                                                                                                            : statusCode == 411
                                                                                                                                ? message = 'Length Required'
                                                                                                                                : statusCode == 412
                                                                                                                                    ? message = 'Precondition Failed'
                                                                                                                                    : statusCode == 413
                                                                                                                                        ? message = 'Payload Too Large'
                                                                                                                                        : statusCode == 414
                                                                                                                                            ? message = 'URI Too Long'
                                                                                                                                            : statusCode == 415
                                                                                                                                                ? message = 'Unsupported Media Type'
                                                                                                                                                : statusCode == 416
                                                                                                                                                    ? message = 'Range Not Satisfiable'
                                                                                                                                                    : statusCode == 417
                                                                                                                                                        ? message = 'Expectation Failed'
                                                                                                                                                        : statusCode == 418
                                                                                                                                                            ? message = 'I’m a teapot'
                                                                                                                                                            : statusCode == 421
                                                                                                                                                                ? message = 'Misdirected Request'
                                                                                                                                                                : statusCode == 422
                                                                                                                                                                    ? message = 'Unprocessable Entity'
                                                                                                                                                                    : statusCode == 423
                                                                                                                                                                        ? message = 'Locked'
                                                                                                                                                                        : statusCode == 424
                                                                                                                                                                            ? message = 'Failed Dependency'
                                                                                                                                                                            : statusCode == 426
                                                                                                                                                                                ? message = 'Upgrade Required'
                                                                                                                                                                                : statusCode == 428
                                                                                                                                                                                    ? message = 'Precondition Required'
                                                                                                                                                                                    : statusCode == 429
                                                                                                                                                                                        ? message = 'Too Many Requests'
                                                                                                                                                                                        : statusCode == 431
                                                                                                                                                                                            ? message = 'Request Header Fields Too Large'
                                                                                                                                                                                            : statusCode == 451
                                                                                                                                                                                                ? message = 'Unavailable For Legal Reasons'
                                                                                                                                                                                                : statusCode == 500
                                                                                                                                                                                                    ? message = 'Internal Server Error'
                                                                                                                                                                                                    : statusCode == 501
                                                                                                                                                                                                        ? message = 'Not Implemented'
                                                                                                                                                                                                        : statusCode == 502
                                                                                                                                                                                                            ? message = 'Bad Gateway'
                                                                                                                                                                                                            : statusCode == 503
                                                                                                                                                                                                                ? message = 'Service Unavailable'
                                                                                                                                                                                                                : statusCode == 504
                                                                                                                                                                                                                    ? message = 'Gateway Timeout'
                                                                                                                                                                                                                    : statusCode == 505
                                                                                                                                                                                                                        ? message = 'HTTP Version Not Supported'
                                                                                                                                                                                                                        : statusCode == 506
                                                                                                                                                                                                                            ? message = 'Variant Also Negotiates'
                                                                                                                                                                                                                            : statusCode == 507
                                                                                                                                                                                                                                ? message = 'Insufficient Storage'
                                                                                                                                                                                                                                : statusCode == 508
                                                                                                                                                                                                                                    ? message = 'Loop Detected'
                                                                                                                                                                                                                                    : statusCode == 510
                                                                                                                                                                                                                                        ? message = 'Not Extended'
                                                                                                                                                                                                                                        : statusCode == 511
                                                                                                                                                                                                                                            ? message = 'Network Authentication Required'
                                                                                                                                                                                                                                            : message = 'Unknown error';

    return message;
  }
}

class ApiResponse {
  late int statusCode;
  late String message;
  late Map data;

  ApiResponse(
      {required this.statusCode, required this.message, required this.data});
}
