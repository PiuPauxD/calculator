import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = "";
  String result = "0";

  List<String> buttons = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "C",
    "0",
    ".",
    "=",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 234, 240),
      body: Column(
        children: [
          //result space
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    input,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Color.fromARGB(255, 75, 38, 221),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 147, 132, 209),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 36, 77, 97),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return customButton(buttons[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton(String text) {
    return InkWell(
      splashColor: const Color.fromARGB(255, 101, 78, 146),
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 64, 171, 221).withOpacity(0.6),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: const Offset(-3, -3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: getColor(text),
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "-" ||
        text == "+" ||
        text == "=" ||
        text == ")" ||
        text == "(" ||
        text == "C") {
      return Color.fromARGB(255, 36, 77, 97);
    }
    return Color.fromARGB(255, 101, 46, 210);
  }

  getBgColor(String text) {
    if (text == "AC") {
      return Color.fromARGB(255, 156, 122, 190);
    }
    if (text == "=") {
      return Color.fromARGB(255, 236, 201, 238);
    }
    if (text == "/" ||
        text == "*" ||
        text == "-" ||
        text == "+" ||
        text == ")" ||
        text == "(" ||
        text == "C") {
      return Color.fromARGB(255, 111, 182, 215);
    }
    return Color.fromARGB(255, 252, 234, 240);
  }

  handleButtons(String text) {
    if (text == "AC") {
      input = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == "=") {
      result = calculate();
      input = result;
      if (input.endsWith(".0")) {
        input = input.replaceAll(".0", "");
      }

      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        return;
      }
    }
    input = input + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(input);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
