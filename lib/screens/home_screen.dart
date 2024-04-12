
// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vpn_basic_project/controller/home_controller.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/vpn_status.dart';
import 'package:vpn_basic_project/screens/location_screen.dart';
import 'package:vpn_basic_project/screens/network_test_screen.dart';
import 'package:vpn_basic_project/widgets/countdown.dart';
import 'package:vpn_basic_project/widgets/home_card.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _controller = Get.put(HomeController());

 bool dark=false;

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
       _controller.vpnState.value = event;
    });
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('SecVPN ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        actions: [
          // for changing from light mode to dark and vice versa
         IconButton(icon: Icon(Icons.dark_mode),
         onPressed: (){
         Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light :ThemeMode.dark);
         },
         ),
           Padding(
             padding: const EdgeInsets.only(right: 10),
             child: IconButton(onPressed: ()=>Get.to(NetworkScreen()),
            icon: Icon(Icons.info_outline,size: 25,)),
           ),
        ],
        ),
        // for navigating to the location screen to change the loctaion
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          shape: CircleBorder(),
          onPressed: ()=> Get.to(LocationScreen()),
          child: Icon(CupertinoIcons.globe,color: Colors.white,),),

      body: Column(
         
          children: [
            SizedBox(height: mj.height*0.1,width: double.infinity,),
            Obx(()=> _vpnButton()),
            //countdown timer for showing the time
            SizedBox(height: 5,),
            Obx(()=> CountDownTimer(startTimer: _controller.vpnState.value ==VpnEngine.vpnConnected)),
            SizedBox(height: 10,),
            Obx(
              ()=> Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //homecard widget for the flag 
                  HomeCard(
                    title: _controller.vpn.value.countryLong.isEmpty?
                    "Country":
                    _controller.vpn.value.countryLong, 
                    subtitle: "FREE", 
                    icon: CircleAvatar(
                      backgroundColor: Colors.lightBlue,
                      radius: 35,
                      child:  _controller.vpn.value.countryLong.isEmpty? Icon(Icons.vpn_lock,size: 40,)
                      :null,
                      backgroundImage: _controller.vpn.value.countryLong.isEmpty?
                      null 
                      :AssetImage("assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png"),
                      
                      )),
                    // homecard widget for denoting the ping 
                    HomeCard(
                    title: _controller.vpn.value.countryLong.isEmpty?"0 ms" :_controller.vpn.value.ping+"ms", 
                    subtitle: "PING", 
                    icon: CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      radius: 35,
                      child: Icon(Icons.bar_chart_sharp,size: 40,),)),
              
                ],
              ),
            ),
            SizedBox(height: 8,),
            // Second Row for denoting the the download and upload speed
            StreamBuilder<VpnStatus?>(
              initialData: VpnStatus(),
              stream: VpnEngine.vpnStatusSnapshot(),
              builder: (context, snapshot) => 
              
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //homecard widget for the flag 
                HomeCard(
                  title: "${snapshot.data?.byteIn ?? "0kbps"}", 
                  subtitle: "DOWNLOAD", 
                  icon: CircleAvatar(
                    backgroundColor: Colors.green[300],
                    radius: 35,
                    child: Icon(Icons.download_rounded,size: 40,),)),
                  // homecard widget for denoting the ping 
                  HomeCard(
                  title: "${snapshot.data?.byteOut ?? "0Kbps"}", 
                  subtitle: "UPLOAD", 
                  icon: CircleAvatar(
                    backgroundColor: Colors.blue[300],
                    radius: 35,
                    child: Icon(Icons.upload_rounded,size: 40,),)),

              ],
              
            ),
            ),
            
          ]),
    );
  }

  

  Widget _vpnButton ()=> Column(
    children: [
      Semantics(
        button: true,
        child: InkWell(
          onTap: (){
            _controller.connectToVpn();
            
          },
          borderRadius: BorderRadius.circular(800),
          child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(shape: BoxShape.circle,color: _controller.getButtonColor.withOpacity(0.1)),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(shape: BoxShape.circle,color: _controller.getButtonColor.withOpacity(0.3)),
              child: Container(
                width: mj.height *.15,
                height: mj.height *.15,
                decoration: BoxDecoration(shape: BoxShape.circle,color: _controller.getButtonColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.power_settings_new_sharp,color: Colors.white,size: 25,),
                    SizedBox(height: 5,),
                    Text(_controller.getText,style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: mj.height * .015),
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
          _controller.vpnState.value==VpnEngine.vpnDisconnected?"Not Connected":
          _controller.vpnState.replaceAll("_", " ").toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 15),)),
      
    ],
  );
}

