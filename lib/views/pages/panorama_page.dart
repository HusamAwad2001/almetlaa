import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:panorama/panorama.dart';
import '../../values/constants.dart';

class PanoramaPage extends StatelessWidget {
  const PanoramaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        toolbarHeight: 50,
        centerTitle: true,
        title: const Text("بانوراما"),
      ),
      body: AlignedGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(5),
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          shrinkWrap: true,
          itemCount: 10,
          crossAxisCount: 3, itemBuilder: (_,index){
        return InkWell(
          onTap: (){
            Get.to(()=>Scaffold(
              appBar: AppBar(
                backgroundColor: Constants.primaryColor,
                toolbarHeight: 50,
                centerTitle: true,
                title: const Text("360"),
              ),
              body: Center(
                child: Panorama(
                  animSpeed: 1.0,
                  sensorControl: SensorControl.Orientation,
                  child: Image.network('https://t4.ftcdn.net/jpg/03/58/04/63/360_F_358046307_Tdl06yGjgJJvY4GNKNsPO0XZDwD95cLO.jpg'),
                ),
              ),
            ));
          },
          child: Image.network("https://cdn.shopify.com/s/files/1/0619/3476/4226/products/318b09164c8247fb804cbd7303e226d8.jpg?v=1655409375&width=800",height: 200,width: double.infinity,fit: BoxFit.cover,),
        );
      }),
    );
  }
}