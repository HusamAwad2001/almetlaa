import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/api.dart';
import '../utils/api_error_model.dart';
import '../views/widgets/loading_dialog.dart';
import '../views/widgets/snack.dart';

class PostController extends GetxController {
  // List posts = [];
  // bool loadingPosts = false;
  // ApiErrorModel? errorModel;

  // String type = "-createdAt";

  @override
  void onInit() {
    getPosts();
    super.onInit();
  }

  List posts = [];
  bool loadingPosts = false;
  bool hasMore = true;
  int currentPage = 1;
  final int limit = 20;
  ApiErrorModel? errorModel;

  Future<void> getPosts({bool isRefresh = false}) async {
    if (loadingPosts) return;

    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      posts.clear();
    }

    if (!hasMore) return;

    loadingPosts = true;
    update();

    await API().get(
      url: '/posts?page=$currentPage&limit=$limit',
      onResponse: (response) {
        if (response.statusCode == 200 && response.data['success']) {
          List newItems = response.data['data'];
          final pagination = response.data['pagination'];

          posts.addAll(newItems);

          final int totalPages = pagination['pages'] ?? 1;
          currentPage++;

          if (currentPage > totalPages || newItems.length < limit) {
            hasMore = false;
          }
        } else {
          hasMore = false;
        }

        loadingPosts = false;
        update();
      },
      onError: (error) {
        errorModel = error;
        loadingPosts = false;
        update();
      },
    );
  }

  final imageController = TextEditingController();

  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  Future<void> pickImage() async {
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      imageFile = File(_pickedFile!.path);
      imageController.text = extractImageName(_pickedFile!.name);
    }
    update();
  }

  String extractImageName(String path) {
    List<String> parts = path.split('.');
    parts.removeLast();
    String imageName = parts.last;
    return imageName;
  }

  bool loadingLike = false;
  like(String id, int index, bool state) {
    if (!loadingLike) {
      loadingLike = true;
      API().put(
          body: {},
          url: '/posts/$id/likePost',
          onResponse: (response) {
            if (response.statusCode == 200) {
              if (response.data['success']) {
                posts[index]['isLiked'] = state;
                posts[index]['countLikes'] =
                    response.data['data']['countLikes'];
                update();
              }
            }
            loadingLike = false;
            update();
          });
    }
  }

  post() async {
    if (imageFile == null) {
      Snack().show(type: false, message: 'يرجى إرفاق صورة');
      return;
    }
    dio.FormData formData = dio.FormData.fromMap({
      'image': await dio.MultipartFile.fromFile(
        imageFile!.path,
        filename: 'image',
      )
    });
    LoadingDialog().dialog();
    API().post(
        body: formData,
        url: '/posts',
        onResponse: (response) {
          log(response.data.toString());
          loadingPosts = false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              response.data['data']['isLiked'] = false;
              List list = [];
              list.add(response.data['data']);
              list.addAll(posts);
              posts = list;
              Get.back();
              Get.back();
              Snack().show(type: true, message: 'تمت الإضافة');
            } else {
              Get.back();
            }
          } else {
            Get.back();
          }
          update();
        });
  }
}
