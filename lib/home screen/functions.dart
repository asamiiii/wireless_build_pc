import 'package:flutter/cupertino.dart';
import 'package:process_run/shell.dart';
import 'package:wireless_build/utils/app_utils.dart';

var shell = Shell();

runTCPCommand() async {
  await shell.run('adb tcpip 5555');
  //shell.kill();
  }

runConnectToIpCommand(String ip,{BuildContext? context}) async {
  if(context!=null){
    await shell.run('adb connect $ip').whenComplete(() =>  AppUtils.showMessage(context, 'Connected Sucseccfully'));
  }
  else{
    await shell.run('adb connect $ip');
  }
  
  //shell.kill();
  }



void killCommand(){
  shell.kill();
}