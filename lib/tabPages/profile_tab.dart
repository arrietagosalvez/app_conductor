import 'package:aplicacion_conductor/authentication/login_screen.dart';
import 'package:aplicacion_conductor/global/global.dart';
import 'package:flutter/material.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Text(
          'Profile', style: TextStyle(fontFamily: 'TypeKeys'),
        ),
        SizedBox(height: 25,),
        ElevatedButton(onPressed:(){
          firebaseAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));

        }, child: const Text('Logout'),
        )
      ]
    );
  }
}
