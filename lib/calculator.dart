import 'dart:math';

import 'package:flutter/material.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = '0';
  String _result = '';
  String _operator = '';
  double num1 = 0.0;
  double num2 = 0.0;

  void _buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _output = '0';
      _result = '';
      _operator = '';
      num1 = 0.0;
      num2 = 0.0;
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == 'x' ||
        buttonText == '/') {
      num1 = double.parse(_output);
      _operator = buttonText;
      _result = '';
    } else if (buttonText == '.') {
      if (_result.contains('.')) {
        return;
      } else {
        _result += buttonText;
      }
    } else if (buttonText == 'x²') {
      num1 = double.parse(_output);
      _result = (num1 * num1).toString();
      num1 = 0.0;
      num2 = 0.0;
      _operator = '';
    } else if (buttonText == '√') {
      num1 = double.parse(_output);
      if (num1 >= 0) {
        _result = sqrt(num1).toString();
      } else {
        _result = 'Error';
      }
      num1 = 0.0;
      num2 = 0.0;
      _operator = '';
    } else if (buttonText == '=') {
      num2 = double.parse(_output);
      try {
        if (_operator == '+') {
          _result = (num1 + num2).toString();
        }
        if (_operator == '-') {
          _result = (num1 - num2).toString();
        }
        if (_operator == 'x') {
          _result = (num1 * num2).toString();
        }
        if (_operator == '/') {
          _result = (num1 / num2).toString();
        }
        if (_operator == 'x²') {
          _result = (num1 * num1).toString();
        }
        if (_operator == '√') {
          _result = (num1 * num1).toString();
        }
      } catch (e) {
        _result = 'Error';
      }
      num1 = 0.0;
      num2 = 0.0;
      _operator = '';
    } else {
      _result += buttonText;
    }

    setState(() {
      if (_result.isEmpty) {
        _output = '0';
      } else {
        try {
          _output = double.parse(_result).toStringAsFixed(2);
        } catch (e) {
          _output = 'Error';
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
      Color textColor, bool isFunctionButton) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.height * 0.01),
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.1,
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: buttonColor,
      ),
      child: TextButton(
        onPressed: () => _buttonPressed(buttonText),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.03,
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        buildButton('C', 1, Colors.red, Colors.white, true),
                        buildButton('x²', 1, Colors.blue, Colors.white, true),
                        buildButton('√', 1, Colors.blue, Colors.white, true),
                        buildButton('/', 1, Colors.blue, Colors.white, true),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        buildButton('7', 1, Colors.white, Colors.black, false),
                        buildButton('8', 1, Colors.white, Colors.black, false),
                        buildButton('9', 1, Colors.white, Colors.black, false),
                        buildButton('x', 1, Colors.blue, Colors.white, true),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        buildButton('4', 1, Colors.white, Colors.black, false),
                        buildButton('5', 1, Colors.white, Colors.black, false),
                        buildButton('6', 1, Colors.white, Colors.black, false),
                        buildButton('-', 1, Colors.blue, Colors.white, true),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        buildButton('1', 1, Colors.white, Colors.black, false),
                        buildButton('2', 1, Colors.white, Colors.black, false),
                        buildButton('3', 1, Colors.white, Colors.black, false),
                        buildButton('+', 1, Colors.blue, Colors.white, true),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        buildButton('.', 1, Colors.white, Colors.black, false),
                        buildButton('0', 1, Colors.white, Colors.black, false),
                        buildButton('00', 1, Colors.white, Colors.black, false),
                        buildButton('=', 1, Colors.blue, Colors.white, true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
