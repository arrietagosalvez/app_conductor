import 'package:aplicacion_conductor/authentication/singup_screen.dart';
import 'package:aplicacion_conductor/splashScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../mainScreens/main_screen.dart';
import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController userTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm(){
    if(!userTextEditingController.text.contains("@")){

      Fluttertoast.showToast(msg: 'No es un correo valido');
    }
    else if(passwordTextEditingController.text.isEmpty ){

      Fluttertoast.showToast(msg: 'Debe ingresar una contraseña');
    }
    else{
      loginDriverNow();
    }
  }

  loginDriverNow()async{

    showDialog(context: context, barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: " Un momento por favor espere...");
        }
    );

    final User? firebaseUser = (
        await firebaseAuth.signInWithEmailAndPassword(
          email: userTextEditingController.text.trim(), password: passwordTextEditingController.text.trim(),).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: "+ msg.toString());
        })
    ).user;
    if(firebaseUser != null){
      DatabaseReference driversReference = FirebaseDatabase.instance.ref().child("drivers");
      driversReference.child(firebaseUser.uid).once().then((driversKey){
        final snap = driversKey.snapshot;
        if(snap.value != null){
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Bien Venido: $userTextEditingController");
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
        else{
          firebaseAuth.signOut();
          Fluttertoast.showToast(msg: "No existe conductor registrado con ese email");
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
        });
    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Hubo un problema. Intente nuevamente: ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset('assets/img/logo.png'),
                ),
                const SizedBox(height: 12),
                Text('Inicio de Sesion', style: TextStyle(fontFamily: 'Urban', fontSize: 35,
                    color: Colors.white, fontWeight: FontWeight.bold),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: userTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Usuario o Correo Electronico',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),

                    )
                  ),

                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: passwordTextEditingController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent)
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: (){
                      validateForm();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo
                    ),
                    child: Text('Iniciar Sesion', style: TextStyle(color: Colors.white,fontSize: 20))

                ),
                const SizedBox(height: 24),
                TextButton(
                    child: Text(
                      'Registro Nuevo Usuario',
                      style: TextStyle(color: Colors.white),
                    ),
                  onPressed: ()
                  {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> SingUpScreen()));
                  },
                )
              ]
          ),
        ),
      ),
    );
  }
}
