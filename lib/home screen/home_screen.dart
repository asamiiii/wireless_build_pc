import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wireless_build/firebase_manager/firebase_manager.dart';
import 'package:wireless_build/home%20screen/functions.dart';
import '../utils/app_utils.dart';

class HomeScreen extends StatefulWidget {
  String userId = '';
  HomeScreen(this.userId);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String ip = '';
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 20), (Timer t) {
      getConnectedDevices();
      setState(() {
        
      });
    } );
    /*List<String> x= getConnectedDevices();
    x.isEmpty?debugPrint('true'):debugPrint('true');*/
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUsersFromFirestore(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('okay');
          }
          var user = snapshot.data;
          return Scaffold(
            appBar: AppUtils.appBar(),
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                          alignment: Alignment.center,
                          color: Colors.greenAccent,
                          width: 200,
                          height: MediaQuery.of(context).size.height*0.40,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                const Text.rich(
                                  TextSpan(
                                    text: 'Make sure Andriod',
                                    style: TextStyle(fontSize: 15),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: ' USB Debugging is Enabled .!',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ])),
                          
                                    const Text.rich(
                                  TextSpan(
                                    text: 'Windows users need to install',
                                    style: TextStyle(fontSize: 15),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: ' ADB driver.!',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ])),
                          
                                    const Text.rich(
                                  TextSpan(
                                    text: 'Make Sure your mobile and pc is connected with',
                                    style: TextStyle(fontSize: 15),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: ' The Same Wifi.!',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ])),
                                   SizedBox(height: 20,)
                                   ,
                                    StreamBuilder(
                                      stream: getConnectedDevices(),
                                      builder: (context, snapshot) {
                                        if(snapshot.connectionState==ConnectionState.waiting){
                                               return const Center(child: SizedBox(),);
                                        }
                                        var x = snapshot.data;
                                      return x!.isEmpty? const Text('Disconnected..!!'):const Text('Connected');
                                    },)
                                
                              ],
                            ),
                          )),
                          SizedBox(height: 30,),
                          IconButton(onPressed: (){
                            getConnectedDevices();
                            refrech();
                            setState(() {
                              
                            });

                          }, icon: const Icon(Icons.refresh,),iconSize: 50,)
                ],
              ),

            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: ()  {
                AppUtils.showLoading(context, 'Loading ....');
                  ip = user?['ipAddress'];
                  //AppUtils.hideLoading(context);
                   runTCPCommand(context);
                  
                   runConnectToIpCommand(ip, context: context);
                   if(commandSuccess==true){
                    AppUtils.showMessage(context, 'Succsess');
                   }
                   else{
                    AppUtils.showMessage(context, 'Failed');
                   }
                   AppUtils.hideLoading(context);
                  // ignore: use_build_context_synchronously
                  setState(() {}
                  
                  );
                  //killCommand();
                
              },
              label: const Text('Connect to My Mobile'),
              icon: const Icon(Icons.wifi),
              backgroundColor:
                  ip.isEmpty ? Colors.blueGrey : Colors.greenAccent,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        });
  }
}
