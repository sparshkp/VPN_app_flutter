import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/api/api.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/network_data.dart';
import 'package:vpn_basic_project/widgets/network_card.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ipData =IPdetails.fromJson({}).obs;
    API.getIPdetails(ipData: ipData);
    return Scaffold(
       appBar: AppBar(
          title: Text('IP Address',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
       ),
       floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10,right: 10),
            child: FloatingActionButton(
            backgroundColor: Colors.blue,
            shape: CircleBorder(),
            onPressed: (){
              ipData.value =IPdetails.fromJson({});
              API.getIPdetails(ipData: ipData);
            } ,
            child: Icon(CupertinoIcons.refresh,color: Colors.white,),),
          ),
      body: Obx(()=>
         ListView(
          padding: EdgeInsets.only(
            left: mj.width*0.04,
            right: mj.width*.04,
            top: mj.height *.01,
            bottom: mj.height*.1
          ),
          physics: BouncingScrollPhysics(),
          children: [
            //ip address
            networkCard(networkData: NetworkData(
              title: "IP Address", 
              subtitle: ipData.value.query, 
              icon: Icon(CupertinoIcons.location_solid,color: Colors.blue,))),
              // internet provider
              networkCard(networkData: NetworkData(
              title: "Internet Provider", 
              subtitle: ipData.value.isp, 
              icon: Icon(CupertinoIcons.building_2_fill,color: Colors.amberAccent,))),
              // location
              networkCard(networkData: NetworkData(
              title: "Location", 
              subtitle: ipData.value.country.isEmpty? "Fetching....":
              '${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}', 
              icon: Icon(CupertinoIcons.location,color: Colors.red,))),
              // pincode 
              networkCard(networkData: NetworkData(
              title: "Pincode", 
              subtitle: ipData.value.zip, 
              icon: Icon(CupertinoIcons.location_solid,color: Colors.lightBlue,))),
              // timezone
              networkCard(networkData: NetworkData(
              title: "Timezone", 
              subtitle: ipData.value.timezone, 
              icon: Icon(CupertinoIcons.clock,color: Colors.green,))),
        
        
          ],
        ),
      ),
    );
  }
}