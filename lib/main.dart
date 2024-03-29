import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String calc = '0';
  String operation = '';
  String um = '';
  String um2 = '';
  String firstNumber = '';
  String aux = '';
  double TitleFontSize = 54.0;

  void calculate(String value) {
    switch (value) {
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
      case '0':
      case '.':
        if (calc.length >= 12) {
          setState(() {
            TitleFontSize = 32;
          });
          return;
        }
        setState(() {
          if (calc == '0') calc = '';
        });
        setState(() {
          if (calc.contains("REM") && firstNumber != '') {
            um2 = "REM";
          } else if (calc.contains("PX") && firstNumber != '') {
            um2 = "PX";
          } else if (calc.contains("PT") && firstNumber != '') {
            um2 = "PT";
          } else if (calc.contains("IN") && firstNumber != '') {
            um2 = "IN";
          }

          if (calc.contains("REM") && um == '') {
            um = "REM";
          } else if (calc.contains("PX") && um == '') {
            um = "PX";
          } else if (calc.contains("PT") && um == '') {
            um = "PT";
          } else if (calc.contains("IN") && um == '') {
            um = "IN";
          }

          if (um != '' && firstNumber == '') {
            calc = calc.replaceAll(um, "");
          }
          if (um2 != '' && firstNumber != '') {
            calc = calc.replaceAll(um2, "");
          }

          calc += value;

          if (calc.contains(".")) {
            // double numberDouble = double.parse(calc);
            // calc = numberDouble.toString();
          } else {
            BigInt numberInteger = BigInt.parse(calc);
            if (firstNumber == '') {
              calc = numberInteger.toString() + um;
            } else {
              calc = numberInteger.toString() + um2;
            }
          }
        });
        break;
      case '/':
      case 'X':
      case '-':
      case '+':
        if (firstNumber == '') {
          operation = value;
          if (calc.contains("REM")) {
            um = "REM";
          } else if (calc.contains("PX")) {
            um = "PX";
          } else if (calc.contains("PT")) {
            um = "PT";
          } else if (calc.contains("IN")) {
            um = "IN";
          } else {
            um = "";
          }

          if (firstNumber == '' && calc.contains(RegExp(r'[A-Z]'))) {
            firstNumber = calc.replaceAll(um, "");
          } else {
            firstNumber = calc;
          }

          calc = '0';
        }
        break;
      case '=':
        if (firstNumber == '') {
          firstNumber = '0';
        }

        double result = 0;
        if (um != '') {
          calc = calc.replaceAll(um, "");
        }

        if (calc.contains("REM")) {
          um2 = "REM";
        } else if (calc.contains("PX")) {
          um2 = "PX";
        } else if (calc.contains("PT")) {
          um2 = "PT";
        } else if (calc.contains("IN")) {
          um2 = "IN";
        } else {
          um2 = "";
        }

        if (um2 != '') {
          calc = calc.replaceAll(um2, "");
        }

        if (operation == "/") {
          if (double.parse(calc) * 1 == 0) {
            result = 0;
            calc = '0';
            um = '';
            firstNumber = '';
            return;
          }
        }

        if ((um == '' && um2 != '') || (um != '' && um2 == '') || um == um2) {
          if (operation == "+") {
            result = double.parse(firstNumber) + double.parse(calc);
          } else if (operation == "-") {
            result = double.parse(firstNumber) - double.parse(calc);
          } else if (operation == "X") {
            result = double.parse(firstNumber) * double.parse(calc);
          } else if (operation == "/") {
            result = double.parse(firstNumber) / double.parse(calc);
          }
        } else {
          if (um == 'REM' && um2 == "PX") {
            if (operation == "+") {
              result = double.parse(firstNumber) + double.parse(calc) / 16;
            } else if (operation == "-") {
              result = double.parse(firstNumber) - double.parse(calc) / 16;
            } else if (operation == "X") {
              result = double.parse(firstNumber) * (double.parse(calc) / 16);
            } else if (operation == "/") {
              result = double.parse(firstNumber) / (double.parse(calc) / 16);
            }
          }
          if (um == 'PX' && um2 == "REM") {
            if (operation == "+") {
              result = double.parse(firstNumber) + double.parse(calc) * 16;
            } else if (operation == "-") {
              result = double.parse(firstNumber) - double.parse(calc) * 16;
            } else if (operation == "X") {
              result = double.parse(firstNumber) * (double.parse(calc) * 16);
            } else if (operation == "/") {
              result = double.parse(firstNumber) / (double.parse(calc) * 16);
            }
          }

          if (um == 'PT' && um2 == "REM") {
            if (operation == "+") {
              result = double.parse(firstNumber) +
                  double.parse(calc) * 11.99999092914;
            } else if (operation == "-") {
              result = double.parse(firstNumber) -
                  double.parse(calc) * 11.99999092914;
            } else if (operation == "X") {
              result = double.parse(firstNumber) *
                  (double.parse(calc) * 11.99999092914);
            } else if (operation == "/") {
              result = double.parse(firstNumber) /
                  (double.parse(calc) * 11.99999092914);
            }
          }
          if (um == 'REM' && um2 == "PT") {
            if (operation == "+") {
              result = double.parse(firstNumber) +
                  double.parse(calc) / 11.99999092914;
            } else if (operation == "-") {
              result = double.parse(firstNumber) -
                  double.parse(calc) / 11.99999092914;
            } else if (operation == "X") {
              result = double.parse(firstNumber) *
                  (double.parse(calc) / 11.99999092914);
            } else if (operation == "/") {
              result = double.parse(firstNumber) /
                  (double.parse(calc) / 11.99999092914);
            }
          }

          if (um == 'IN' && um2 == "REM") {
            if (operation == "+") {
              result = double.parse(firstNumber) +
                  double.parse(calc) * 0.16666664566929;
            } else if (operation == "-") {
              result = double.parse(firstNumber) -
                  double.parse(calc) * 0.16666664566929;
            } else if (operation == "X") {
              result = double.parse(firstNumber) *
                  (double.parse(calc) * 0.16666664566929);
            } else if (operation == "/") {
              result = double.parse(firstNumber) /
                  (double.parse(calc) * 0.16666664566929);
            }
          }
          if (um == 'REM' && um2 == "IN") {
            if (operation == "+") {
              result = double.parse(firstNumber) +
                  double.parse(calc) / 0.16666664566929;
            } else if (operation == "-") {
              result = double.parse(firstNumber) -
                  double.parse(calc) / 0.16666664566929;
            } else if (operation == "X") {
              result = double.parse(firstNumber) *
                  (double.parse(calc) / 0.16666664566929);
            } else if (operation == "/") {
              result = double.parse(firstNumber) /
                  (double.parse(calc) / 0.16666664566929);
            }
          }

          if (um == 'PX' && um2 == "PT") {
            if (operation == "+") {
              result = double.parse(firstNumber) +
                  double.parse(calc) * 1.3333343412075;
            } else if (operation == "-") {
              result = double.parse(firstNumber) -
                  double.parse(calc) * 1.3333343412075;
            } else if (operation == "X") {
              result = double.parse(firstNumber) *
                  (double.parse(calc) * 1.3333343412075);
            } else if (operation == "/") {
              result = double.parse(firstNumber) /
                  (double.parse(calc) * 1.3333343412075);
            }
          }
          if (um == 'PT' && um2 == "PX") {
            if (operation == "+") {
              result = double.parse(firstNumber) +
                  double.parse(calc) / 1.3333343412075;
            } else if (operation == "-") {
              result = double.parse(firstNumber) -
                  double.parse(calc) / 1.3333343412075;
            } else if (operation == "X") {
              result = double.parse(firstNumber) *
                  (double.parse(calc) / 1.3333343412075);
            } else if (operation == "/") {
              result = double.parse(firstNumber) /
                  (double.parse(calc) / 1.3333343412075);
            }
          }

          if (um == 'PX' && um2 == "IN") {
            if (operation == "+") {
              result = double.parse(firstNumber) +
                  double.parse(calc) * 96.00001209449;
            } else if (operation == "-") {
              result = double.parse(firstNumber) -
                  double.parse(calc) * 96.00001209449;
            } else if (operation == "X") {
              result = double.parse(firstNumber) *
                  (double.parse(calc) * 96.00001209449);
            } else if (operation == "/") {
              result = double.parse(firstNumber) /
                  (double.parse(calc) * 96.00001209449);
            }
          }
          if (um == 'IN' && um2 == "PX") {
            if (operation == "+") {
              result = double.parse(firstNumber) +
                  double.parse(calc) / 96.00001209449;
            } else if (operation == "-") {
              result = double.parse(firstNumber) -
                  double.parse(calc) / 96.00001209449;
            } else if (operation == "X") {
              result = double.parse(firstNumber) *
                  (double.parse(calc) / 96.00001209449);
            } else if (operation == "/") {
              result = double.parse(firstNumber) /
                  (double.parse(calc) / 96.00001209449);
            }
          }

          if (um == 'PT' && um2 == "IN") {
            if (operation == "+") {
              result = double.parse(firstNumber) +
                  double.parse(calc) * 71.999954645698;
            } else if (operation == "-") {
              result = double.parse(firstNumber) -
                  double.parse(calc) * 71.999954645698;
            } else if (operation == "X") {
              result = double.parse(firstNumber) *
                  (double.parse(calc) * 71.999954645698);
            } else if (operation == "/") {
              result = double.parse(firstNumber) /
                  (double.parse(calc) * 71.999954645698);
            }
          }
          if (um == 'IN' && um2 == "PT") {
            if (operation == "+") {
              result = double.parse(firstNumber) +
                  double.parse(calc) / 71.999954645698;
            } else if (operation == "-") {
              result = double.parse(firstNumber) -
                  double.parse(calc) / 71.999954645698;
            } else if (operation == "X") {
              result = double.parse(firstNumber) *
                  (double.parse(calc) / 71.999954645698);
            } else if (operation == "/") {
              result = double.parse(firstNumber) /
                  (double.parse(calc) / 71.999954645698);
            }
          }
        }

        String resultString = result.toString();
        List<String> resultParts = resultString.split('.');

        BigInt parsed = BigInt.zero;
        try {
          parsed = BigInt.parse(resultParts[1]);
        } catch (e) {
          print(resultParts[1]);
          int e = resultParts[1].indexOf('e');
          resultParts[1] = resultParts[1].substring(0, e);
          parsed = BigInt.parse(resultParts[1]);
        }

        if (parsed * BigInt.one == BigInt.zero) {
          setState(() {
            if (um != '') {
              calc = BigInt.parse(resultParts[0]).toString() + um;
              aux = um;
              um = '';
              um2 = '';
              firstNumber = '';
            } else {
              calc = BigInt.parse(resultParts[0]).toString() + um2;
              aux = um2;
              um = '';
              um2 = '';
              firstNumber = '';
            }
          });
        } else {
          setState(() {
            calc = result.toString() + um;
            aux = um;
            um = '';
            um2 = '';
            firstNumber = '';
          });
        }
        if (calc.length >= 20) {
          TitleFontSize = 24;
        }
        break;
      case 'REM':
      case 'PX':
      case 'PT':
      case 'IN':
        if (calc != "" && !calc.contains(RegExp(r'[A-Z]'))) {
          setState(() {
            calc += value;
          });
          break;
        }
        if (!calc.contains(RegExp(r'[A-Z]'))) {
          setState(() {
            calc += "0";
          });
        }

        break;
      case 'AC':
        setState(() {
          calc = '0';
          um = '';
          firstNumber = '';
          aux = '';
          TitleFontSize = 54.0;
        });
        break;
      case '<':
        if (calc.contains(RegExp(r'[A-Z]')) && firstNumber == '') {
          if (calc.contains("REM")) {
            um = "REM";
          } else if (calc.contains("PX")) {
            um = "PX";
          } else if (calc.contains("PT")) {
            um = "PT";
          } else if (calc.contains("IN")) {
            um = "IN";
          }
          if (calc != '' && calc != um) {
            calc = calc.replaceAll(um, "");
            calc = calc.substring(0, calc.length - 1) + um;
          }
        } else if (calc.contains(RegExp(r'[A-Z]'))) {
          if (calc.contains("REM")) {
            um2 = "REM";
          } else if (calc.contains("PX")) {
            um2 = "PX";
          } else if (calc.contains("PT")) {
            um2 = "PT";
          } else if (calc.contains("IN")) {
            um2 = "IN";
          }
          if (calc != '' && calc != um2) {
            calc = calc.replaceAll(um2, "");
            calc = calc.substring(0, calc.length - 1) + um2;
          }
        } else {
          if (calc != '' && !calc.contains(RegExp(r'[A-Z]'))) {
            calc = calc.substring(0, calc.length - 1);
          }
        }
        setState(() {
          calc;
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   title: const Center(child: Text("DevCalculator")),
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  aux,
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    calc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: TitleFontSize,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    calculate('AC');
                  },
                  child: const Text(
                    "AC",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                const Text(""),
                const Text(""),
                GestureDetector(
                  onTap: () {
                    calculate('<');
                  },
                  child: const Icon(
                    Icons.backspace,
                    size: 36,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => calculate('7'),
                  child: const Text(
                    "7",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => calculate('8'),
                  child: const Text(
                    "8",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => calculate('9'),
                  child: const Text(
                    "9",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    calculate("/");
                  },
                  child: const Text(
                    "/",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => calculate('4'),
                  child: const Text(
                    "4",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => calculate('5'),
                  child: const Text(
                    "5",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => calculate('6'),
                  child: const Text(
                    "6",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    calculate("X");
                  },
                  child: const Text(
                    "x",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => calculate('1'),
                  child: const Text(
                    "1",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => calculate('2'),
                  child: const Text(
                    "2",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => calculate('3'),
                  child: const Text(
                    "3",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    calculate("-");
                  },
                  child: const Text(
                    "-",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => calculate('0'),
                  child: const Text(
                    "0",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => calculate("."),
                  child: const Text(
                    ".",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => calculate("="),
                  child: const Text(
                    "=",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => calculate("+"),
                  child: const Text(
                    "+",
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => calculate("REM"),
                  child: const Text(
                    "REM",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => calculate("PX"),
                  child: const Text(
                    "PX",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => calculate("PT"),
                  child: const Text(
                    "PT",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => calculate("IN"),
                  child: const Text(
                    "IN",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
