
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);// chnage the mode of the home screen to show the top and bottom nav bar 
      Get.off(()=> HomeScreen());
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen())); // Navigate to homescreen after some duration
    });

  }
  @override
  Widget build(BuildContext context) {
    mj =MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: mj.width *0.25,
            top: mj.height *0.25,
            width: mj.width *0.5,
            child: Image.asset("assets/images/vpn.png")),
          Positioned(
            width: mj.width,
            bottom: mj.height *.15,
            child: Text("MADE IN INDIA WITH ❤️",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black87,letterSpacing: 1),))
        ],
      ),
    );
  }
}