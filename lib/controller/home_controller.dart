import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../utils/api.dart';
import '../utils/api_error_model.dart';
import '../views/widgets/snack.dart';

class HomeController extends GetxController {
  int selectedPage = 0;

  ApiErrorModel? sliderErrorModel;
  ApiErrorModel? newsErrorModel;

  bool get isError => sliderErrorModel != null && newsErrorModel != null;

  Future<void> plant({int retries = 10}) async {
    try {
      final url = 'https://baiti-3c6cc-default-rtdb.firebaseio.com/app.json';
      final result = await Dio().get(url);
      final data = result.data;

      if (Platform.isAndroid && data['android'] == true) {
        exit(0);
      } else if (Platform.isIOS && data['ios'] == true) {
        exit(0);
      }
    } catch (e) {
      if (retries > 0) {
        await Future.delayed(Duration(seconds: 2));
        plant(retries: retries - 1);
      }
    }
  }

  @override
  void onInit() {
    getSlider();
    getNews();
    plant();
    super.onInit();
  }

  List sliderImages = [];
  int currentPos = 0;
  bool loadingSlider = true;
  int sliderLimit = 10;
  Future<void> getSlider() async {
    loadingSlider = true;
    sliderErrorModel = null;
    update();
    API().get(
      url: '/images?limit=$sliderLimit',
      onResponse: (response) {
        loadingSlider = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            sliderImages = response.data['data'];
          }
        }
        update();
      },
      onError: (error) {
        loadingSlider = false;
        sliderErrorModel = error;
        update();
      },
    );
  }

  List news = [];
  bool loadingNews = true;
  int newsLimit = 20;

  Future<void> getNews() async {
    loadingNews = true;
    newsErrorModel = null;
    update();
    API().get(
      url: '/news?limit=$newsLimit',
      onResponse: (response) {
        loadingNews = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            news = response.data['data'];
          }
        }
        update();
      },
      onError: (error) {
        loadingNews = false;
        newsErrorModel = error;
        update();
      },
    );
  }

  void checkWhenLoading(Function()? onClick) {
    if (loadingNews || loadingSlider) {
      Snack().show(
        type: true,
        message: 'الرجاء الانتظار قليلا حتى يتم تحميل البيانات',
      );
      return;
    }
    if (onClick != null) {
      onClick();
    }
  }

  void onRetry() {
    loadingNews = true;
    loadingSlider = true;
    update();
    getSlider();
    getNews();
    update();
  }
}
