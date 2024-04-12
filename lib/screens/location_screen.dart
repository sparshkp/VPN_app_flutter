// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/controller/location_controller.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/widgets/vpn_card.dart';

class LocationScreen extends StatelessWidget {
   LocationScreen({super.key});

  final _controller =LocationController();

  Widget build(BuildContext context) {
    if(_controller.vpnList.isEmpty)
    _controller.getVpnData();
    return Obx(()=>
       Scaffold(
        appBar: AppBar(
          title: Text('VPN Locations(${_controller.vpnList.length}) ',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          actions:[]
          ),

          // button for refreshing the vpn data 
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10,right: 10),
            child: FloatingActionButton(
            backgroundColor: Colors.blue,
            shape: CircleBorder(),
            onPressed: (){
              _controller.getVpnData();
            } ,
            child: Icon(CupertinoIcons.refresh,color: Colors.white,),),
          ),
          body:  _controller.isLoading.value?
          _loadingWidget():_controller.vpnList.isEmpty? _noVpnFound() :_vpnData()
      ),
    );
  }

  // for showing the list of vpn servers available
  _vpnData()=>ListView.builder(
    physics: BouncingScrollPhysics(),
    padding: EdgeInsets.only(
      top: mj.height*.025,
      bottom: mj.height*.1,
      right: mj.width*.04,
      left: mj.width*.04),
    itemCount: _controller.vpnList.length ,
    itemBuilder: (context,index)=>vpnCard(vpn: _controller.vpnList[index],)
    

  );

  // for showing the loading animation
  _loadingWidget()=>Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 70,left: 70),
              child: Lottie.network("https://lottie.host/8faf8b71-b47d-4b94-8d5a-0d4a12a5e5e1/utDZVRvAJS.json"),
            ),
            Text("Loading VPNs....",
            style: TextStyle(
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
              fontSize: 16),)
          ],
        );

          _noVpnFound()=>Center(
           child: Text("No VPNs Found ",
              style: TextStyle(
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
                fontSize: 16),
                ),
 );
}