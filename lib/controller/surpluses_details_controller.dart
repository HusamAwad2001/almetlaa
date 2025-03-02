import 'dart:developer';

import 'package:almetlaa/views/widgets/snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../core/global.dart';
import '../routes/routes.dart';
import '../utils/api.dart';
import '../views/widgets/loading_dialog.dart';

class SurplusesDetailsController extends GetxController {
  final priceController = TextEditingController();
  final arguments = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    socket.connect();
    getProposals();
    generalPrice = arguments['price'];
    maxOfferPrice = listProposals.isEmpty ? 0 : listProposals.last['price'];
  }

  late int generalPrice;
  late int maxOfferPrice;

  List listProposals = [];
  bool loadingProposals = true;

  io.Socket socket = io.io(
    'https://dolphin-app-792st.ondigitalocean.app',
    <String, dynamic>{
      'transports': ['websocket'],
    },
  );

  @override
  void onClose() {
    socket.close();
    log("connected======>${socket.connected}");
    super.onClose();
  }

  getProposals() {
    API().get(
      url: '/proposals/${arguments['_id']}',
      onResponse: (response) async {
        loadingProposals = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            listProposals = response.data['data'];
            log("connected======>${socket.connected}");
            socket.on('${arguments['_id']}', (data) {
              print('-----------------------------');
              log(data.toString());
              print(arguments['_id'] + "socket======>" + data['data'].toString());
              listProposals.add(data['data']);
              update();
            });
          }
        }
        update();
      },
    );
  }

  createProposal() {
    LoadingDialog().dialog();
    API().post(
      url: '/proposals',
      body: {
        'price': priceController.text,
        'surplus': arguments['_id'],
      },
      onResponse: (response) {
        if (response.statusCode == 200) {
          if (response.data['success']) {
            Get.back();
            Snack().show(type: true, message: 'تم إضافة العرض');
            priceController.clear();
          }
          update();
        }
        if (response.statusCode == 409) {
          if (!response.data['success']) {
            Get.back();
            Snack().show(type: false, message: response.data['error']);
          }
        }
      },
    );
  }

  validate() {
    if (Global.token.isEmpty || Global.user.isEmpty) {
      Snack().show(type: false, message: 'يرجى تسجيل الدخول');
      Get.offAllNamed(Routes.loginPage);
      return;
    }
    if (priceController.text.isEmpty || priceController.text == '0') {
      Snack().show(
        type: false,
        message: 'يرجى إضافة السعر',
      );
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    createProposal();
  }
}
