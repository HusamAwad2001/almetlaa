import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart'as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/api.dart';
import '../views/widgets/loading_dialog.dart';
import '../views/widgets/snack.dart';

class PostController extends GetxController{
  @override
  void onInit() {
    getPosts(type);
    super.onInit();
  }

  String type="-createdAt";
  List posts=[];
  bool loadingPosts=true;
  getPosts(String type){
    API().get(
        url: '/posts?limit=100&sort=$type',
        onResponse: (response) {
          loadingPosts=false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              posts = response.data['data'];
            }
          }
          update();
        });
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

  bool loadingLike=false;
  like(String id,int index,bool state){
    if(!loadingLike){
      loadingLike=true;
      API().put(
          body: {},
          url: '/posts/$id/likePost',
          onResponse: (response) {
            if (response.statusCode == 200) {
              if (response.data['success']) {
                posts[index]['isLiked']=state;
                posts[index]['countLikes']=response.data['data']['countLikes'];
                update();
              }
            }
            loadingLike=false;
            update();
          });
    }
  }
  post()async{
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
          loadingPosts=false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              response.data['data']['isLiked']=false;
              List list=[];
              list.add(response.data['data']);
              list.addAll(posts);
              posts=list;
              Get.back();
              Get.back();
              Snack().show(type: true, message: 'تمت الإضافة');
            }else{
              Get.back();
            }
          }else{
            Get.back();
          }
          update();
        });
  }
}