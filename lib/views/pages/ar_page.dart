import 'package:flutter/material.dart';
import '../../values/constants.dart';

class ARPage extends StatelessWidget {
  const ARPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        toolbarHeight: 50,
        centerTitle: true,
        title: const Text("الأثاث",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: const Center(child: Text('لا توجد شركات')),
    );
  }
}
