import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";

  String equation = "";
  String result = "";
  String expression = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "";
        result = "";
        _output = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        result = "";
        if (equation == "") {
          _output = "0";
        } else {
          _output = equation;
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('×', '*');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }

        _output = result;
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
        _output = equation;
      }
    });
  }

  Widget buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: FlatButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        color: buttonColor,
        padding: EdgeInsets.all(24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.bottomRight,
            ),
            Row(
              children: <Widget>[
                buildButton("C", Colors.red),
                buildButton("⌫", Colors.blue),
                buildButton("÷", Colors.blue),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton("7", Colors.grey),
                buildButton("8", Colors.grey),
                buildButton("9", Colors.grey),
                buildButton("×", Colors.blue),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton("4", Colors.grey),
                buildButton("5", Colors.grey),
                buildButton("6", Colors.grey),
                buildButton("-", Colors.blue),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton("1", Colors.grey),
                buildButton("2", Colors.grey),
                buildButton("3", Colors.grey),
                buildButton("+", Colors.blue),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton(".", Colors.grey),
                buildButton("0", Colors.grey),
                buildButton("00", Colors.grey),
                buildButton("=", Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
