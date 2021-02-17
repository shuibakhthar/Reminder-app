import 'package:flutter/material.dart';

class CustomAlertDialogHealth {

  BuildContext context;
  String e;

  CustomAlertDialogHealth({
    this.context,
    this.e,
  });


   AlertDialogDisplay() async {
    print(e);
    switch(e){
      case "time":
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                backgroundColor: Colors.blue,
                title: Text("Error"),
                content: Text("Need TIME for atleast 1 Dose"),
                actions: [
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Okay",
                      style: TextStyle(color: Color.fromRGBO(255, 0, 0, 1)),
                    ),
                  ),
                ],
              );
            }
        );
        break;
      case "name":
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                backgroundColor: Colors.blue,
                title: Text("Error"),
                content: Text("Fill the Medicine Name"),
                actions: [
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Okay",
                      style: TextStyle(color: Color.fromRGBO(255, 0, 0, 1)),
                    ),
                  ),
                ],
              );
            }
        );
        break;
    }
  }



}