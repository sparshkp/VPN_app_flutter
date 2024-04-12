// ignore_for_file: camel_case_types, unused_element, unrelated_type_equality_checks

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controller/home_controller.dart';
import 'package:vpn_basic_project/helpers/preferences.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';

class vpnCard extends StatelessWidget {
  final Vpn vpn;
  const vpnCard({super.key, required this.vpn});

  @override
  Widget build(BuildContext context) {
    final controller =Get.find<HomeController>();
    return Card(
      margin: EdgeInsets.symmetric( vertical :mj.height *.01),
      elevation: 3,

      child: InkWell(
        onTap: (){
          controller.vpn.value =vpn;
          Preferences.vpn =vpn;
          Get.back();
          if(controller.vpnState == VpnEngine.vpnConnected){
            VpnEngine.stopVpn();
            Future.delayed(Duration(seconds: 2),(){ // wait for the vpn to discoonect and then start coonecting after 2 sec
              controller.connectToVpn();
            });
          }else{
            controller.connectToVpn();
          }
          
        },
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          leading: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset("assets/flags/${vpn.countryShort.toLowerCase()}.png",
              height: 40,
              width: mj.width*.15,
              fit: BoxFit.cover,),
            )),
        
          // name of the country 
          title: Text(vpn.countryLong),
          // speed of the server 
          subtitle: Row(
            children: [
              Icon(Icons.speed_sharp,color: Colors.blue,),
              SizedBox(width: 4,),
              Text(_formatBytes(vpn.speed, 2))
            ]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
            children: [
              Text(vpn.numVpnSessions.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Theme.of(context).lightText),),
              SizedBox(width: 5,),
              Icon(CupertinoIcons.person_3,color: Colors.blue,),
              
              
            ]),
        ),
      ),
    );
  }
  // for formatting th speed 
  String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ['Bps', "Kbps", "Mbps", "Gbps", "Tbps"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}