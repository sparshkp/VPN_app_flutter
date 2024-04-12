import 'package:get/get.dart';
import 'package:vpn_basic_project/api/api.dart';
import 'package:vpn_basic_project/helpers/preferences.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class LocationController extends GetxController{
  List<Vpn> vpnList=Preferences.vpnList;
  final RxBool isLoading = false.obs;

  Future<void> getVpnData()async{
  isLoading.value =true;
  vpnList.clear();
  vpnList= await API.getVPNServers();
  isLoading.value =false;
  }
}