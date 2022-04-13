import 'package:aplicacion_conductor/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';

class CarInfScreen extends StatefulWidget {
  const CarInfScreen({Key? key}) : super(key: key);

  @override
  State<CarInfScreen> createState() => _CarInfScreenState();
}

class _CarInfScreenState extends State<CarInfScreen> {

  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carColorlTextEditingController = TextEditingController();
  TextEditingController carPatentTextEditingController = TextEditingController();
  TextEditingController carTypeTextEditingController = TextEditingController();

  List<String> carTypeList = ["4 Puertas", "5 Puertas", "3 Puertas"];
  String? selectedCarType;

  saveCarInfo(){
    Map driverCarMap = {
      "car_color": carColorlTextEditingController.text.trim(),
      "car_number": carPatentTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "car_type": carTypeTextEditingController.text.trim(),
      "car_dors_number": selectedCarType,

    };

    DatabaseReference driversReference = FirebaseDatabase.instance.ref().child("drivers");
    driversReference.child(currentFirebaseUser!.uid).child("car_details").set(driverCarMap);
    //currentFirebaseUser = firebaseUser;
    Fluttertoast.showToast(msg: "Cuenta creada correctamente");
    Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 10),
              Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset('assets/img/logo.png'),
              ),

              const SizedBox(height: 12),
              const Text('Registro del Vehiculo', style: TextStyle(fontFamily: 'Urban', fontSize: 30,
                  color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: carModelTextEditingController,
                decoration: InputDecoration(
                    labelText: 'Modelo de Auto',
                    hintText: 'Suzuki Swift 2017',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: UnderlineInputBorder(
                    ),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 12)
                ),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: carColorlTextEditingController,
                decoration: InputDecoration(
                    labelText: 'Modelo de Auto',
                    hintText: 'Suzuki Swift 2017',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: UnderlineInputBorder(
                    ),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 12)
                ),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: carPatentTextEditingController,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  labelText: 'Numero de Placa',
                  hintText: '4512-LAM',
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                  ),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 12)
                ),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: carTypeTextEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Tipo de Vehiculo',
                  hintText: 'Hatchback 5 puertas',
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 12)
                ),
              ),
              const SizedBox(height: 20),
              DropdownButton(
                dropdownColor: Colors.blueGrey,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 25,
                  hint: const Text('Seleccione el tipo de Auto',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
              ),
                  value: selectedCarType,
                   onChanged: (newValue)
                   {
                    setState(() {
                      selectedCarType = newValue.toString();
                    });
                  },
                items: carTypeList.map((car){

                  return DropdownMenuItem(
                    child: Text(
                      car,
                      style: const TextStyle(color: Colors.white),
                    ),
                    value: car,
                  );

                }).toList(),
              ),
              const SizedBox(height: 15),

              ElevatedButton(
                  onPressed: (){
                    if(carColorlTextEditingController.text.isNotEmpty
                    &&carModelTextEditingController.text.isNotEmpty&&
                    carPatentTextEditingController.text.isNotEmpty&&
                        carPatentTextEditingController.text.trim().isNotEmpty&&
                    selectedCarType !=null){

                      saveCarInfo();

                    }
                    //Navigator.push(context, MaterialPageRoute(builder: (C) => CarInfScreen()));

                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo
                  ),
                  child: Text('Guardar Vehiculo', style: TextStyle(color: Colors.white,fontSize: 20))

              )

            ],
          ),
        ),
      )
    );
  }
}
