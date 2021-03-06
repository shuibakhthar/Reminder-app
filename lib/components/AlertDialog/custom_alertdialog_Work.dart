import 'package:flutter/material.dart';

class CustomAlertDialogWork{

  BuildContext context;
  String e;

  CustomAlertDialogWork({
    this.context,
    this.e,
  });

  AlertDialogDisplay() async{
    switch(e){
      case "name":
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                backgroundColor: Colors.blue,
                title: Text("Error"),
                content: Text("Fill the Work Title"),
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
      case "invalid":
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                backgroundColor: Colors.blue,
                title: Text("Error"),
                content: Text("Fill all details"),
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
    };
  }
}