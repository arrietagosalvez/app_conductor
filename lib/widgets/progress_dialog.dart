import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  //const ProgressDialog({Key? key}) : super(key: key);

  String? message;

  ProgressDialog({this.message});



  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black87,
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
              children:[
                const SizedBox(height: 10),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                ),
                const SizedBox(height: 10),
                Text(
                  message!,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                )
              ]

          )
      )

      )
    );
  }
}
