import 'package:flutter/material.dart';

const String cardBackgroundPath = "lib/assets/images/22.jpeg";

class CardWidget extends StatefulWidget {
  static double cardWidth = 670 / 2;
  static double cardHeight = 420 / 2;

  String cardNumber;
  String cardName;
  String cardMonth;
  String cardYear;

  CardWidget(
      {super.key,
      required this.cardNumber,
      required this.cardName,
      required this.cardMonth,
      required this.cardYear});
  @override
  State<StatefulWidget> createState() => CardWidgetState();
}

class CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return (SizedBox(
      width: CardWidget.cardWidth,
      height: CardWidget.cardHeight,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(12),
            image: const DecorationImage(
              image: AssetImage(cardBackgroundPath),
              fit: BoxFit.cover,
            )),
        child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ////////////////////
                //////////////////// CARD TOP ROW
                ////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 82 / 2,
                      width: 101 / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(5),
                          image: const DecorationImage(
                              image: AssetImage("lib/assets/images/chip.png"),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      height: 106 / 2.5,
                      width: 200 / 2.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'lib/assets/images/${_getCardType()}.png'),
                              fit: BoxFit.contain)),
                    )
                  ],
                ),

                ////////////////////
                //////////////////////// CARD MIDDLE ROW
                ////////////////////
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadiusDirectional.circular(10)),
                  child: Text(
                    processCardNumberString(widget.cardNumber),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        decoration: TextDecoration.none),
                  ),
                ),
                ////////////////////
                //////////////////////// CARD BOTTOM ROW
                ////////////////////
                Row(children: [
                  Container(
                    width: 214,
                    height: 50,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Card Holder",
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.none,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          widget.cardName.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 5,
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Expires",
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.none,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "${widget.cardMonth != "" ? widget.cardMonth : "\t"}/${widget.cardYear != "" ? int.parse(widget.cardYear) - 2000 : ""}",
                          style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ],
            )),
      ),
    ));
  }

  String processCardNumberString(String cardNumber) {
    String base = "#### #### #### ####";
    if (widget.cardNumber.startsWith('34') ||
        widget.cardNumber.startsWith('37')) {
      base = "#### ###### #####";
    }

    for (int i = 0; i < cardNumber.length; i++) {
      base = base.replaceFirst('#', cardNumber[i]);
    }
    return base;
  }

  String _getCardType() {
    String number = widget.cardNumber;
    RegExp re = RegExp(r"^4");
    if (re.hasMatch(number)) return "visa";

    re = RegExp(r"^(34|37)");
    if (re.hasMatch(number)) return "amex";

    re = RegExp(r"^5[1-5]");
    if (re.hasMatch(number)) return "mastercard";

    re = RegExp(r"^6011");
    if (re.hasMatch(number)) return "discover";

    re = RegExp(r'^9792');
    if (re.hasMatch(number)) return 'troy';

    return "visa";
  }
}

class CardWidgetBack extends StatefulWidget {
  String cardCVV;
  CardWidgetBack({super.key, required this.cardCVV});

  @override
  State<StatefulWidget> createState() => CardWidgetBackState();
}

class CardWidgetBackState extends State<CardWidgetBack> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: CardWidget.cardWidth,
        height: CardWidget.cardHeight,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(12),
                image: const DecorationImage(
                  image: AssetImage(cardBackgroundPath),
                  fit: BoxFit.cover,
                )),
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.black,
                      height: 50,
                      width: CardWidget.cardWidth,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "CVV",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 16),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.centerRight,
                          width: CardWidget.cardWidth - 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadiusDirectional.circular(5)),
                          child: Text(
                            widget.cardCVV,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 25, width: 0),
                        Container(
                          height: 504 / 30,
                          width: 2400 / 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(5),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "lib/assets/images/discover.png"),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
