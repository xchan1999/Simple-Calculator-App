import 'package:flutter/material.dart';

class CalcButtons extends StatelessWidget {
  final color;
  final textcolor;
  final String buttontext;
  final buttonTapped;

  CalcButtons({this.color, this.textcolor, this.buttontext, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: color,
            child: Center(
              child: Text(buttontext, style: TextStyle(color: textcolor, fontSize: 25),),
            ),
          ),
        ),
      ),
    );
  }
}
