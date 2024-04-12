import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/dialogs.dart';
import 'package:vpn_basic_project/helpers/preferences.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/models/vpn_config.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';



class HomeController extends GetxController{
  
  final Rx<Vpn> vpn = Preferences.vpn.obs;
 
  
  final vpnState = VpnEngine.vpnDisconnected.obs;

  void connectToVpn() {
    ///Stop right here if user not select a vpn
    if(vpn.value.openVPNConfigDataBase64.isEmpty) {
      Dialogue.info(msg: "Select a country first");
      return;
      } ;

    if (vpnState.value == VpnEngine.vpnDisconnected) {

      final data =Base64Decoder().
      convert(vpn.value.openVPNConfigDataBase64);
      final config =Utf8Decoder().convert(data);
      final vpnConfig =VpnConfig(
        country: vpn.value.countryLong,
        username: "vpn",
        password: "vpn",
        config: config);
      ///Start if stage is disconnected
      VpnEngine.startVpn(vpnConfig);
      
    } else {
      ///Stop if stage is "not" disconnected
      VpnEngine.stopVpn();
      
    }
  }

  // vpn button color
  Color get getButtonColor{
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
      return Colors.blue;

      case VpnEngine.vpnConnected:
      return Colors.green;  
        
      default:
      return Colors.orange;
    }
  }
  // to change the text based on the vpn connection
  String get getText{
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
      return "Tap to Connect";

      case VpnEngine.vpnConnected:
      return "Disconnect";  
        
      default:
      return "Connecting...";
    }
  }


}