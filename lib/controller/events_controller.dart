import 'package:get/get.dart';

import '../utils/api.dart';

class EventsController extends GetxController{

  @override
  void onInit() {
    getEvents();
    super.onInit();
  }

  List events=[];
  bool loadingEvents=true;
  getEvents(){
    loadingEvents=true;
    update();
    API().get(
        url: '/events?limit=100',
        onResponse: (response) {
          loadingEvents=false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              events = response.data['data'];
            }
          }
          update();
        });
  }

  searchEvents(String search){
    loadingEvents=true;
    update();
    API().get(
        url: '/events?limit=100&search=$search',
        onResponse: (response) {
          loadingEvents=false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              events = response.data['data'];
            }
          }
          update();
        });
  }
}