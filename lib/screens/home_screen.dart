import 'package:flutter/material.dart';
import 'package:calulator_app/screens/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion,
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAnswer,
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    //clear button
                    if (index == 0) {
                      return CalcButtons(
                        buttonTapped: (){
                          setState(() {
                            userQuestion = '';
                          });
                        },
                        buttontext: buttons[index],
                        color: Colors.green,
                        textcolor: Colors.white,
                      );
                      //delete button
                    } else if (index == 1) {
                      return CalcButtons(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = userQuestion.substring(0,userQuestion.length-1);
                          });
                        },
                        buttontext: buttons[index],
                        color: Colors.red,
                        textcolor: Colors.white,
                      );
                      //equal button
                    } else if (index == buttons.length-1) {
                      return CalcButtons(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttontext: buttons[index],
                        color: Colors.black,
                        textcolor: Colors.white,
                      );
                      //rest buttons
                    }
                    else {
                      return CalcButtons(
                        buttonTapped: (){
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        buttontext: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.blue
                            : Colors.deepPurple[50],
                        textcolor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
  void equalPressed(){
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }

}
