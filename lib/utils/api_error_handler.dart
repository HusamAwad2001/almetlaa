import '../utils/api_error_model.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {
  final ApiErrorModel apiErrorModel;

  ServerException({required this.apiErrorModel});
}

class ApiErrorHandler {
  static ServerException handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ServerException(
            apiErrorModel: ApiErrorModel(
              message: 'انتهت مهلة الاتصال بالخادم، حاول مرة أخرى.',
            ),
          );
        case DioExceptionType.sendTimeout:
          return ServerException(
            apiErrorModel: ApiErrorModel(
              message:
                  'انتهت مهلة إرسال البيانات، تأكد من اتصالك وحاول مجددًا.',
            ),
          );
        case DioExceptionType.receiveTimeout:
          return ServerException(
            apiErrorModel: ApiErrorModel(
              message:
                  'انتهت مهلة استلام البيانات، تأكد من الشبكة وحاول مرة أخرى.',
            ),
          );
        case DioExceptionType.badCertificate:
          return ServerException(
            apiErrorModel: ApiErrorModel(
              message: 'الشهادة الأمنية غير صالحة، الرجاء المحاولة لاحقًا.',
            ),
          );
        case DioExceptionType.cancel:
          return ServerException(
            apiErrorModel: ApiErrorModel(
              message: 'تم إلغاء الطلب قبل اكتماله.',
            ),
          );
        case DioExceptionType.connectionError:
          return ServerException(
            apiErrorModel: ApiErrorModel(
              message: 'لا يوجد اتصال بالإنترنت، تأكد من الشبكة وحاول مجددًا.',
            ),
          );
        case DioExceptionType.unknown:
          return ServerException(
            apiErrorModel: ApiErrorModel(
              message: 'حدث خطأ غير معروف، الرجاء المحاولة لاحقًا.',
            ),
          );
        case DioExceptionType.badResponse:
          _handleError(error);
          break;
      }
    }
    return ServerException(
      apiErrorModel: ApiErrorModel(
        message: 'حدث خطأ غير متوقع، يرجى المحاولة لاحقًا.',
      ),
    );
  }
}

ServerException _handleError(DioException error) {
  if (error.response != null) {
    final data = error.response!.data;
    if (data is Map<String, dynamic> && (data.containsKey('message'))) {
      final apiErrorModel = ApiErrorModel.fromJson(data);
      return ServerException(apiErrorModel: apiErrorModel);
    } else {
      return ServerException(
        apiErrorModel: ApiErrorModel(
          message: 'حدث خطأ غير معروف من الخادم.',
        ),
      );
    }
  } else {
    return ServerException(
      apiErrorModel: ApiErrorModel(
        message: 'لم يتم استلام رد من الخادم.',
      ),
    );
  }
}
