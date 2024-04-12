
import 'dart:convert';
import 'dart:developer';
import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helpers/dialogs.dart';
import 'package:vpn_basic_project/helpers/preferences.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class API{

  static Future<List<Vpn>>  getVPNServers() async{
    final List<Vpn> vpnList=[];

   try {
    final response = await get(Uri.parse("http://www.vpngate.net/api/iphone/"));
    final csvString =response.body.split("#")[1].replaceAll("*", " ");
    List<List<dynamic>> list = const CsvToListConverter().convert(csvString);

    final header = list[0];
     
    for(int i=1;i<list.length-1;i++){
      Map<String,dynamic> tempJSON ={};
      
       for(int j=0;j<header.length;j++){
      tempJSON.addAll({header[j].toString():list[i][j]});
       }
       vpnList.add(Vpn.fromJson(tempJSON ));
      
      
    }
   } catch (e) {
    Dialogue.error(msg: e.toString());
     log("\ngetVpnServersE:$e");
   }
   vpnList.shuffle();
   if(vpnList.isNotEmpty) Preferences.vpnList =vpnList;
   return vpnList;
   
  }
  static Future<void>  getIPdetails({required Rx<IPdetails> ipData}) async{
   try {
    final response = await get(Uri.parse("http://ip-api.com/json/"));
    final data = jsonDecode(response.body);
    ipData.value =IPdetails.fromJson(data);
    
   } catch (e) {
    Dialogue.error(msg: e.toString());
     log("\ngetIPdetailsE:$e");
   }
   
   
  }

}