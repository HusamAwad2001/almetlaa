import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/api.dart';

class HomeController extends GetxController {
  int selectedPage = 0;
  bool appbarEnabled = false;
  ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.offset > (0)) {
        appbarEnabled = true;
        update();
      } else {
        appbarEnabled = false;
        update();
      }
    });
    getSlider();
    getNews();
    getVideos();
    super.onInit();
  }

  List sliderImages = [];
  int currentPos = 0;
  bool loadingSlider = true;
  getSlider() {
    API().get(
        url: '/images?limit=100',
        onResponse: (response) {
          loadingSlider = false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              sliderImages = response.data['data'];
            }
          }
          update();
        });
  }

  List news = [];
  bool loadingNews = true;
  int newsLimit = 6;
  getNews() {
    API().get(
        url: '/news',
        onResponse: (response) {
          loadingNews = false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              news = response.data['data'];
              newsLimit = response.data['pagination']['limit'];
            }
          }
          update();
        });
  }

  List videos = [];
  bool loadingVideos = true;
  int videoLimit = 6;
  getVideos() {
    API().get(
        url: '/video',
        onResponse: (response) {
          loadingVideos = false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              videos = response.data['data'];
              videoLimit = response.data['pagination']['limit'];
            }
          }
          update();
        });
  }
}
