import 'package:flutter/material.dart';

class MainActionButton extends StatelessWidget {
  MainActionButton({
    this.width,
    this.onPressed,
    this.label,
  });

  final VoidCallback onPressed;
  final String label;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: width,
      child: RaisedButton(
        onPressed: onPressed,
        elevation: 5,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.blue,
        child: Text(
          label,
          style:TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
