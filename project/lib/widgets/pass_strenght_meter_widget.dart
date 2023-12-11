import 'package:flutter/material.dart';

enum PasswordStrength {
  tooShort,
  weak,
  fair,
  good,
  strong,
}

const TextStyle _defaultLabelStyle = TextStyle(
  fontSize: 14,
  color: Colors.grey,
  decoration: TextDecoration.none,
);

const TextStyle _defaultTextStyle = TextStyle(
  fontSize: 14,
  color: Colors.white,
  decoration: TextDecoration.none,
);

class PasswordStrMeterWidget extends StatefulWidget {
  final double barHeight;
  final double borderWidth;
  final Color borderColor;
  final Color? color;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final int animationDuration;
  final void Function(String password, PasswordStrength strength)?
      onPasswordChanged;
  String password = "";

  PasswordStrMeterWidget(
      {Key? key,
      this.onPasswordChanged,
      this.barHeight = 5.0,
      this.borderWidth = 1.0,
      this.borderColor = Colors.white,
      this.color = Colors.transparent,
      this.labelStyle = _defaultLabelStyle,
      this.animationDuration = 200,
      this.textStyle = _defaultTextStyle})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PasswordStrMeterWidgetState();
}

class PasswordStrMeterWidgetState extends State<PasswordStrMeterWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: widget.color,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Password strength: ", style: widget.labelStyle),
                  Text(_getStrengthMessage(),
                      style: TextStyle(
                          fontSize: 12,
                          color: _getProgressColor(),
                          decoration: TextDecoration.none))
                ],
              ),
              LinearProgressIndicator(
                value: _getProgressPercentage(),
                backgroundColor: Colors.grey,
                color: _getProgressColor(),
              ),
            ],
          ),
          Container(height: 5),
          TextField(
            onChanged: (value) {
              setState(() {
                widget.password = value;
              });
              if (widget.onPasswordChanged != null) {
                widget.onPasswordChanged!(value, _getPasswordStrength());
              }
            },
            cursorColor: Colors.white,
            style: widget.textStyle,
            obscureText: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                )),
          ),
          Text("Minimum 8 characters", style: widget.labelStyle),
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
        return Colors.lightGreen;
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
