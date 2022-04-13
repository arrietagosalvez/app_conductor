import 'dart:async';
import 'package:aplicacion_conductor/global/global.dart';
import 'package:aplicacion_conductor/mainScreens/main_screen.dart';
import 'package:flutter/material.dart';
import '../authentication/login_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer(){
    Timer(Duration(seconds: 3), ()async{
      if(await firebaseAuth.currentUser != null) {
        currentFirebaseUser= firebaseAuth.currentUser;
        print('Usuario$currentFirebaseUser');
        Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset('assets/img/logo.png'),
          const SizedBox(height: 10),
          const Text('Taxi App  2-0',
            style: TextStyle(
            fontSize: 35, fontFamily: 'Urban',
            color: Colors.blue,
              )
            ),
           ],
        )
      )
    );
  }
}
