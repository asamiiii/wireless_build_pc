import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:process_run/shell.dart';
import 'package:wireless_build/utils/app_utils.dart';

import '../firebase_manager/firebase_manager.dart';

var shell = Shell();

runTCPCommand(BuildContext context) async {
  await shell.run('adb tcpip 5555').whenComplete(() => commandSuccess = true);
  //shell.kill();
}

Future<void> runConnectToIpCommand(String ip, {BuildContext? context}) async {
  if (context != null) {
    //AppUtils.hideLoading(context);
    await shell.run('adb connect $ip').whenComplete(
      () {
        commandSuccess=true;
        AppUtils.showMessage(
            context, 'Successfuly , Now You can Remove a USB Cable .');
      },
    );
  }
  //shell.kill();
}

   Stream<List<String>> getConnectedDevices()async* {
    List<String> processResultList =[];
    List<String> splittedList =[];
    await shell.run('adb devices -l').then((value) {
    processResultList = value.map((e) => e.stdout.toString()).toList().first.trim().split('\r\n');
    processResultList.removeAt(0);
    
  });
  //var processResultList =  processResult.map((e) => e.stdout.toString()).toList();
  //List<String> outputList = processResultList[0].trim().split('\n');
  if(processResultList.isNotEmpty){
   splittedList = processResultList[0].trim().split(RegExp(r'\s+'));
   debugPrint('-----------> ${splittedList}');
   yield splittedList;
  }

  debugPrint('-----------> ${processResultList}');

  yield processResultList;

 
}

void refrech()async{
   await shell.run('adb disconnect');
}
