import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  Timer? _timer;
  int remainingSeconds = 0;
  final time = '00.00'.obs;

  startTimer(int second) {
    remainingSeconds = second;
    _timer = Timer.periodic(1.seconds, (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;
        time.value =
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        remainingSeconds--;
      }
    });
  }
}
