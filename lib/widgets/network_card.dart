// ignore_for_file: camel_case_types, unused_element, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/network_data.dart';

class networkCard extends StatelessWidget {
  final NetworkData networkData;
  const networkCard({super.key, required this.networkData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric( vertical :mj.height *.01),
      elevation: 3,

      child: InkWell(
        onTap: (){},
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          leading: Icon(networkData.icon.icon, color: networkData.icon.color,size: networkData.icon.size??25,),
        
          // name of the country 
          title: Text(networkData.title),
          // speed of the server 
          subtitle: Text(networkData.subtitle)
        ),
      ),
    );
  }
 
}