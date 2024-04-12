import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogue{

  static success(){

  }

  static error({required String msg}){
  Get.snackbar("Error", "Couldn't fetch the location details",colorText: Colors.white,backgroundColor: Colors.redAccent.withOpacity(.9));
  }

  static info({required String msg}){
    Get.snackbar("Info", msg,colorText: Colors.white);
  }
}