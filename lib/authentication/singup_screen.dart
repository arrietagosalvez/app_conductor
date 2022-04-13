import 'package:aplicacion_conductor/authentication/car_inf_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../widgets/progress_dialog.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm(){
    if(nameTextEditingController.text.length < 3){

      Fluttertoast.showToast(msg: 'El nombre de usuario debe ser de al meos tres caracteres');

    }else if(!emailTextEditingController.text.contains("@")){

      Fluttertoast.showToast(msg: 'No es un correo valido');
    }
    else if(phoneTextEditingController.text.isEmpty){

      Fluttertoast.showToast(msg: 'El numero de telefeno es obligatorio');
    }
    else if(passwordTextEditingController.text.length < 5 ){

      Fluttertoast.showToast(msg: 'La contraseña debe contener al menos 5 caracteres');
    }
    else{
      saveDriverInfoNow();
  }
}

  saveDriverInfoNow()async{

    showDialog(context: context, barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Por favor espere...");
        }
        );

    final User? firebaseUser = (
        await firebaseAuth.createUserWithEmailAndPassword(
            email: emailTextEditingController.text.trim(), password: passwordTextEditingController.text.trim(),).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: "+ msg.toString());
        })
    ).user;
    if(firebaseUser != null){

      Map driverMap = {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),

      };

      DatabaseReference driversReference = FirebaseDatabase.instance.ref().child("drivers");
      driversReference.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Cuenta creada correctamente");
      Navigator.push(context, MaterialPageRoute(builder: (c)=>CarInfScreen()));


    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "No se pudo crear la cuenta: ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(18.0),
                  child: Image.asset('assets/img/logo.png'),
                 ),
              const SizedBox(height: 12),
              Text('Registro de Conductor', style: TextStyle(fontFamily: 'TypeKeys', fontSize: 20,
                  color: Colors.white, fontWeight: FontWeight.bold),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: nameTextEditingController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Nombre',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: UnderlineInputBorder(
                  ),
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10)
                ),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                  ),
                ),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Telefono',
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                ),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purpleAccent)
                  ),
                ),
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: (){
                    validateForm();
                    //Navigator.push(context, MaterialPageRoute(builder: (C) => CarInfScreen()));

              },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo
                  ),
                child: Text('Registrar', style: TextStyle(color: Colors.white,fontSize: 20))

              )
                ],
              ),
        ),
        )
    );
  }
}
