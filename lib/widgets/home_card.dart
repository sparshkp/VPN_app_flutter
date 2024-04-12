import 'package:flutter/material.dart';
import 'package:vpn_basic_project/main.dart';

class HomeCard extends StatelessWidget {
  final String title ,subtitle;
  final Widget icon;
  const HomeCard(
    {super.key,
    required this.title,
    required this.subtitle,
    required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mj.width *.45,
      child: Column(
        children: [
          icon,
          SizedBox(height: 3,),
          Text(title,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
          SizedBox(height: 2,),
          Text(subtitle,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Theme.of(context).lightText),)
        ],
      ),
    );
  }
}