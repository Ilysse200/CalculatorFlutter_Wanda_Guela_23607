import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _output = '0';
  double currentResult = 0.0;
  String operand = '';
  String currentInput = '';

  void buttonPressed(String buttonText) {
    if (buttonText == 'CLEAR') {
      setState(() {
        _output = '0';
        currentResult = 0.0;
        operand = '';
        currentInput = '';
      });
    } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
      if (currentInput.isNotEmpty) {
        // Perform the operation if there is a current input
        double currentNumber = double.parse(currentInput);
        performOperation(currentNumber);
        operand = buttonText;
        currentInput = '';
      }
    } else if (buttonText == '.') {
      if (!currentInput.contains('.')) {
        currentInput += buttonText;
      }
    } else if (buttonText == '=') {
      if (currentInput.isNotEmpty) {
        double currentNumber = double.parse(currentInput);
        performOperation(currentNumber);
        currentInput = '';
        operand = '';
      }
    } else {
      currentInput += buttonText;
    }

    setState(() {
      _output = currentInput.isNotEmpty ? currentInput : currentResult.toString();
    });

    print(_output);
  }

  void performOperation(double currentNumber) {
    if (operand == '+') {
      currentResult += currentNumber;
    } else if (operand == '-') {
      currentResult -= currentNumber;
    } else if (operand == '*') {
      currentResult *= currentNumber;
    } else if (operand == '/') {
      if (currentNumber != 0) {
        currentResult /= currentNumber;
      } else {
        // Handle division by zero
        print('Error: Division by zero');
      }
    } else {
      // If there's no operand, set the current result to the current number
      currentResult = currentNumber;
    }
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: MaterialButton(
        child: Text(buttonText),
        onPressed: () => buttonPressed(buttonText),
        color: Colors.blueGrey,
        textColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(_output),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildButton('7'),
                    buildButton('8'),
                    buildButton('9'),
                    buildButton('/'),
                  ],
                ),
                Row(
                  children: [
                    buildButton('4'),
                    buildButton('5'),
                    buildButton('6'),
                    buildButton('*'),
                  ],
                ),
                Row(
                  children: [
                    buildButton('1'),
                    buildButton('2'),
                    buildButton('3'),
                    buildButton('-'),
                  ],
                ),
                Row(
                  children: [
                    buildButton('.'),
                    buildButton('0'),
                    buildButton('00'),
                    buildButton('+'),
                  ],
                ),
                Row(
                  children: [
                    buildButton('CLEAR'),
                    buildButton('='),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
