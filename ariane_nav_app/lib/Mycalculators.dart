import 'package:flutter/material.dart';

void main() {
  runApp(MyCalculator());
}

class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Building a Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _display = '0';
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = '';
  bool _waitingForSecondOperand = false;

  void _onButtonPressed(String label) {
    setState(() {
      if (label == 'C') {
        _clear();
      } else if (_isOperator(label)) {
        _handleOperator(label);
      } else if (label == '=') {
        _calculateResult();
      } else if (label == '.') {
        _handleDecimal();
      } else {
        _handleNumber(label);
      }
    });
  }

  bool _isOperator(String label) {
    return label == '+' || label == '-' || label == '*' || label == '/';
  }

  void _handleOperator(String label) {
    if (_operator.isNotEmpty) {
      _calculateResult();
    }
    _firstOperand = double.parse(_display);
    _operator = label;
    _waitingForSecondOperand = true;
  }

  void _calculateResult() {
    if (_operator.isEmpty) return;

    _secondOperand = double.parse(_display);

    switch (_operator) {
      case '+':
        _display = (_firstOperand + _secondOperand).toString();
        break;
      case '-':
        _display = (_firstOperand - _secondOperand).toString();
        break;
      case '*':
        _display = (_firstOperand * _secondOperand).toString();
        break;
      case '/':
        _display = (_firstOperand / _secondOperand).toString();
        break;
    }

    _operator = '';
    _waitingForSecondOperand = false;
  }

  void _handleNumber(String label) {
    if (_waitingForSecondOperand) {
      _display = label;
      _waitingForSecondOperand = false;
    } else {
      _display = _display == '0' ? label : _display + label;
    }
  }

  void _handleDecimal() {
    if (_waitingForSecondOperand) {
      _display = '0.';
      _waitingForSecondOperand = false;
    } else if (!_display.contains('.')) {
      _display = _display + '.';
    }
  }

  void _clear() {
    _display = '0';
    _firstOperand = 0;
    _secondOperand = 0;
    _operator = '';
    _waitingForSecondOperand = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Calculator(
        display: _display,
        onButtonPressed: _onButtonPressed,
      ),
    );
  }
}

class Calculator extends StatelessWidget {
  final String display;
  final Function(String) onButtonPressed;

  Calculator({required this.display, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                display,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton('7', isOperator: false, onPressed: onButtonPressed),
              CalculatorButton('8', isOperator: false, onPressed: onButtonPressed),
              CalculatorButton('9', isOperator: false, onPressed: onButtonPressed),
              CalculatorButton('/', isOperator: true, onPressed: onButtonPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton('4', isOperator: false, onPressed: onButtonPressed),
              CalculatorButton('5', isOperator: false, onPressed: onButtonPressed),
              CalculatorButton('6', isOperator: false, onPressed: onButtonPressed),
              CalculatorButton('*', isOperator: true, onPressed: onButtonPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton('1', isOperator: false, onPressed: onButtonPressed),
              CalculatorButton('2', isOperator: false, onPressed: onButtonPressed),
              CalculatorButton('3', isOperator: false, onPressed: onButtonPressed),
              CalculatorButton('-', isOperator: true, onPressed: onButtonPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton('0', isOperator: false, onPressed: onButtonPressed),
              CalculatorButton('.', isOperator: false, onPressed: onButtonPressed),
              CalculatorButton('=', isOperator: true, onPressed: onButtonPressed),
              CalculatorButton('+', isOperator: true, onPressed: onButtonPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton('C', isOperator: true, onPressed: onButtonPressed),
            ],
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String label;
  final bool isOperator;
  final Function(String) onPressed;

  CalculatorButton(this.label, {required this.isOperator, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => onPressed(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: isOperator ? Colors.orange : Colors.white, // Button color
            foregroundColor: isOperator ? Colors.white : Colors.black, // Text color
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
