import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab2_flu/Widgets/card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _cardFrontState = true;
  String _cardNumber = "";
  String _cardName = "";
  String _cardMonth = "";
  String _cardYear = "";
  String _cardCvv = "";

  @override
  Widget build(BuildContext context) {
    Iterable<DropdownMenuItem<String>> possibleMonthsMenuItem = possibleMonths
        .map((String item) => DropdownMenuItem(value: item, child: Text(item)));
    Iterable<DropdownMenuItem<String>> possibleYearsMenuItem = possibleYears
        .map((String item) => DropdownMenuItem(value: item, child: Text(item)));
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blueGrey,
            alignment: Alignment.topCenter,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                LayoutBuilder(builder: (ctx, constraints) {
                  return Container(
                      height: constraints.maxHeight,
                      child: SingleChildScrollView(
                          child: Container(
                        padding: EdgeInsets.fromLTRB(
                            0, CardWidget.cardHeight / 2, 0, 0),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              15, CardWidget.cardHeight / 2 + 10, 15, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ////////
                              //////// CARD NUMBER FIELD
                              ////////
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Card Number",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.blueAccent),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 2),
                                    child: TextField(
                                      maxLength: RegExp(r"^(34|37)")
                                              .hasMatch(_cardNumber)
                                          ? 18
                                          : 19,
                                      keyboardType: TextInputType.number,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _cardNumber =
                                              newValue.replaceAll(' ', '');
                                        });
                                      },
                                      onTap: () {
                                        setState(() {
                                          _cardFrontState = true;
                                        });
                                      },
                                      inputFormatters: [SpaceInputFormatter()],
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          counterText: ""),
                                    ),
                                  ),
                                ],
                              ),
                              Container(height: 10),
                              ////////
                              //////// CARD NAME FIELD
                              ////////
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Card Name",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.blueAccent),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 2),
                                    child: TextField(
                                      maxLength: 20,
                                      onChanged: (String newName) {
                                        setState(() {
                                          _cardName = newName;
                                        });
                                      },
                                      onTap: () {
                                        setState(() {
                                          _cardFrontState = true;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          counterText: ""),
                                    ),
                                  ),
                                ],
                              ),
                              Container(height: 10),
                              ////////
                              //////// EXPIRATION DATES FIELDS
                              ////////
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Expiration Date",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.blueAccent),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: DropdownButtonFormField<
                                                        String>(
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        _cardFrontState = true;
                                                      });
                                                    },
                                                    hint: const Text("Month"),
                                                    items:
                                                        possibleMonthsMenuItem
                                                            .toList(),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _cardMonth = value!;
                                                      });
                                                    })),
                                            Container(width: 10),
                                            Expanded(
                                                child: DropdownButtonFormField<
                                                        String>(
                                                    onTap: () {
                                                      setState(() {
                                                        _cardFrontState = true;
                                                      });
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    hint: const Text("Year"),
                                                    items: possibleYearsMenuItem
                                                        .toList(),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _cardYear = value!;
                                                      });
                                                    })),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(width: 10),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "CVV",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blueAccent),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                          onChanged: (String value) {
                                            setState(() {
                                              _cardCvv = value;
                                            });
                                          },
                                          onTap: () {
                                            setState(() {
                                              _cardFrontState = false;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              counterText: ""),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                              Container(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blueAccent),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ))),
                                    child: const Text(
                                      "Submit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )));
                }),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _cardFrontState
                      ? CardWidget(
                          cardNumber: _cardNumber,
                          cardName: _cardName,
                          cardMonth: _cardMonth,
                          cardYear: _cardYear,
                        )
                      : CardWidgetBack(cardCVV: _cardCvv),
                )
              ],
            )));
  }

  var possibleMonths = List.generate(12,
      (index) => (index + 1) < 10 ? "0${index + 1}" : (index + 1).toString());
  var possibleYears =
      List.generate(20, (index) => ((DateTime.now()).year + index).toString());
}

class SpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String cleanedText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    String formattedText = '';

    if (RegExp(r"^(34|37)").hasMatch(cleanedText)) {
      // FORMAT : XXXX XXXXXX XXXXX
      for (int i = 0; i < cleanedText.length; i++) {
        if (i == 4 || i == 10) {
          formattedText += ' ';
        }
        formattedText += cleanedText[i];
      }
    } else {
      // FORMAT XXXX XXXX XXXX XXXX
      for (int i = 0; i < cleanedText.length; i += 4) {
        int end = i + 4;
        if (end > cleanedText.length) {
          end = cleanedText.length;
        }
        formattedText += cleanedText.substring(i, end);
        if (end < cleanedText.length) {
          formattedText += ' ';
        }
      }
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
