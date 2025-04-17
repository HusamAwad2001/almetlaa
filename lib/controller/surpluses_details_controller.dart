import 'dart:async';
import 'dart:developer';

import '../../views/widgets/snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../core/global.dart';
import '../routes/routes.dart';
import '../utils/api.dart';
import '../utils/api_error_model.dart';
import '../views/widgets/loading_dialog.dart';

class SurplusesDetailsController extends GetxController {
  final priceController = TextEditingController();
  final arguments = Get.arguments['item'];
  late Duration remainingTime;

  Timer? _countdownTimer;

  @override
  void onInit() {
    super.onInit();
    remainingTime = Get.arguments['remainingTime'] as Duration;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds <= 1) {
        timer.cancel();
        remainingTime = Duration.zero;
      } else {
        remainingTime -= const Duration(seconds: 1);
      }
      update();
    });

    socket.connect();
    getProposals();
    generalPrice = Get.arguments['item']['price'];
    maxOfferPrice = proposals.isEmpty ? 0 : proposals.last['price'];
  }

  @override
  void onClose() {
    _countdownTimer?.cancel();
    socket.close();
    log("connected======>${socket.connected}");
    super.onClose();
  }

  late int generalPrice;
  late int maxOfferPrice;

  io.Socket socket = io.io(
    'https://dolphin-app-792st.ondigitalocean.app',
    <String, dynamic>{
      'transports': ['websocket'],
    },
  );

  List proposals = [];
  bool loadingProposals = false;
  bool hasMore = true;
  int currentPage = 1;
  final int limit = 5;
  ApiErrorModel? errorModel;

  Future<void> getProposals({bool isRefresh = false}) async {
    if (loadingProposals) return;

    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      proposals.clear();
    }

    if (!hasMore) return;

    loadingProposals = true;
    update();

    await API().get(
      url: '/proposals/${arguments['_id']}?page=$currentPage&limit=$limit',
      onResponse: (response) {
        if (response.statusCode == 200 && response.data['success']) {
          List newItems = response.data['data'];
          proposals.addAll(newItems);

          final pagination = response.data['pagination'];
          if (pagination != null) {
            final int totalPages = pagination['pages'] ?? 1;
            currentPage++;

            if (currentPage > totalPages || newItems.length < limit) {
              hasMore = false;
            }
          } else {
            hasMore = false;
          }
          socket.on('${Get.arguments['item']['_id']}', (data) {
            proposals.add(data['data']);
            update();
          });
        } else {
          hasMore = false;
        }

        errorModel = null;
        loadingProposals = false;
        update();
      },
      onError: (error) {
        errorModel = error;
        loadingProposals = false;
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
        if (response.statusCode == 200 && response.data['success']) {
          Get.back();
          Get.back();
          Snack().show(type: true, message: 'تم إضافة العرض');
          priceController.clear();
        }
        update();
      },
      onError: (errorModel) {
        Get.back();
        Snack().show(type: false, message: errorModel.message ?? 'حدث خطأ ما');
        update();
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
