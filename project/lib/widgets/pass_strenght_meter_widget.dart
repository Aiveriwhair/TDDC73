import 'package:flutter/material.dart';

enum PasswordStrength {
  tooShort,
  weak,
  fair,
  good,
  strong,
}

class PasswordStrMeterWidget extends StatefulWidget {
  final double barHeight;
  final double borderWidth;
  final Color borderColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final String? label;
  final TextStyle? labelStyle;
  final int animationDuration;
  String password = "";

  PasswordStrMeterWidget(
      {Key? key,
      this.barHeight = 5.0,
      this.borderWidth = 1.0,
      this.borderColor = Colors.white,
      this.borderRadius,
      this.backgroundColor = Colors.grey,
      this.label,
      this.labelStyle,
      this.animationDuration = 200})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PasswordStrMeterWidgetState();
}

class PasswordStrMeterWidgetState extends State<PasswordStrMeterWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  widget.password = value;
                });
              },
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Password strength: ",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.none)),
                  Text(_getStrengthMessage(),
                      style: TextStyle(
                          fontSize: 12,
                          color: _getProgressColor(),
                          decoration: TextDecoration.none))
                ],
              ),
              // Progress bar :
              Container(
                height: widget.barHeight,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  border: Border.all(
                    color: widget.borderColor,
                    width: widget.borderWidth,
                  ),
                  borderRadius: widget.borderRadius,
                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: widget.animationDuration),
                  width: MediaQuery.of(context).size.width *
                      0.8 *
                      _getProgressPercentage(),
                  decoration: BoxDecoration(
                    color: _getProgressColor(),
                    borderRadius: widget.borderRadius,
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
      const Text("Minimum 8 characters",
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              decoration: TextDecoration.none)),
    ]));
  }

  double _getProgressPercentage() {
    switch (_getPasswordStrength()) {
      case PasswordStrength.tooShort:
        return 0.0;
      case PasswordStrength.weak:
        return 0.25;
      case PasswordStrength.fair:
        return 0.5;
      case PasswordStrength.good:
        return 0.75;
      case PasswordStrength.strong:
        return 1;
      default:
        return 0.0;
    }
  }

  Color _getProgressColor() {
    switch (_getPasswordStrength()) {
      case PasswordStrength.tooShort:
        return Colors.red;
      case PasswordStrength.weak:
        return Colors.orange;
      case PasswordStrength.fair:
        return Colors.yellow;
      case PasswordStrength.good:
        return Colors.green;
      case PasswordStrength.strong:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  String _getStrengthMessage() {
    switch (_getPasswordStrength()) {
      case PasswordStrength.tooShort:
        return "Too short";
      case PasswordStrength.weak:
        return "Weak";
      case PasswordStrength.fair:
        return "Fair";
      case PasswordStrength.good:
        return "Good";
      case PasswordStrength.strong:
        return "Strong";
      default:
        return "Too short";
    }
  }

  PasswordStrength _getPasswordStrength() {
    var password = widget.password;
    int strengthScore = 0;
    /*
      Has more than 8 characters
      Contains both lowercase and uppercase letters
      Contains at least one numerical character
      Contains special characters
      Has more than 12 characters
     */
    if (password.length <= 8) return PasswordStrength.tooShort;
    if (password.length > 8) {
      strengthScore += 1;
    }
    if (password.contains(RegExp(r'[A-Z]'))) {
      strengthScore += 1;
    }
    if (password.contains(RegExp(r'[a-z]'))) {
      strengthScore += 1;
    }
    if (password.contains(RegExp(r'[0-9]'))) {
      strengthScore += 1;
    }
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      strengthScore += 1;
    }
    if (password.length > 12) {
      strengthScore += 1;
    }
    switch (strengthScore) {
      case 1:
        return PasswordStrength.weak;
      case 2:
        return PasswordStrength.weak;
      case 3:
        return PasswordStrength.fair;
      case 4:
        return PasswordStrength.fair;
      case 5:
        return PasswordStrength.good;
      case 6:
        return PasswordStrength.strong;
      default:
        return PasswordStrength.tooShort;
    }
  }
}
