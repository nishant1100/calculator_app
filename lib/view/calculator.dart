import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "←",
    "%",
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
    "0",
    ".",
    "=",
  ];

  double first = 0;
  double second = 0;
  String operation = "";
  String history = ""; // Store calculation history

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox.shrink(), // Remove title from app bar
        backgroundColor: const Color.fromARGB(255, 131, 118, 241),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // App title
            const Text(
              'Nishant Calculator App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 131, 118, 241),
              ),
            ),
            const SizedBox(height: 20), // Space below the title

            // Display Area
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              height: 150, // Adjusted height to prevent overflow
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // History Text
                  Text(
                    history,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Current Input Text
                  Text(
                    _textController.text,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20), // Space between display area and the grid

            // Grid of Buttons
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  final symbol = lstSymbols[index];
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (symbol == "=" ||
                              symbol == "+" ||
                              symbol == "-" ||
                              symbol == "*" ||
                              symbol == "/" ||
                              symbol == "%" ||
                              symbol == "←" ||
                              symbol == "C")
                          ? const Color.fromARGB(166, 132, 167, 243)
                          : Colors.grey[300],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {
                      setState(() {
                        if (symbol == "C") {
                          _textController.text = "";
                          first = 0;
                          second = 0;
                          operation = "";
                          history = "";
                        } else if (symbol == "←") {
                          if (_textController.text.isNotEmpty) {
                            _textController.text = _textController.text
                                .substring(0, _textController.text.length - 1);
                          }
                        } else if (["+", "-", "*", "/", "%"].contains(symbol)) {
                          first = double.tryParse(_textController.text) ?? 0;
                          operation = symbol;
                          _textController.text = "";
                        } else if (symbol == "=") {
                          second = double.tryParse(_textController.text) ?? 0;
                          double result;
                          switch (operation) {
                            case "+":
                              result = first + second;
                              break;
                            case "-":
                              result = first - second;
                              break;
                            case "*":
                              result = first * second;
                              break;
                            case "/":
                              result = second != 0 ? first / second : double.nan;
                              break;
                            case "%":
                              result = first % second;
                              break;
                            default:
                              result = 0;
                          }
                          history =
                              "$first $operation $second = $result"; // Update history
                          _textController.text = result.toString();
                        } else {
                          _textController.text += symbol;
                        }
                      });
                    },
                    child: Text(
                      symbol,
                      style: TextStyle(
                        fontSize: 24,
                        color: symbol == "=" ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
