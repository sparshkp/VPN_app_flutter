import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class Preferences{

  static late Box _box;

   static Future<void> initializeHive()async {
    await Hive.initFlutter();
    _box = await Hive.openBox("MyBox");

   }

   // for storing the single selected vpn details

   static Vpn get vpn =>Vpn.fromJson(jsonDecode(_box.get('vpn') ?? "{}"));
   static set vpn(Vpn v)=> _box.put('vpn', jsonEncode(v));

   

   // for storing the servers list in the database
    //for storing vpn servers details
  static List<Vpn> get vpnList {
    List<Vpn> temp = [];
    final data = jsonDecode(_box.get('vpnList') ?? '[]');

    for (var i in data) temp.add(Vpn.fromJson(i));

    return temp;
  }

  static set vpnList(List<Vpn> v) => _box.put('vpnList', jsonEncode(v));
  
}