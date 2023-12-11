import 'package:flutter/material.dart';

enum ProgressDirection {
  leftToRight,
  rightToLeft,
  both,
}

class ProgressBarWidget extends StatefulWidget {
  final int maxValue;
  final double barHeight;
  int currentValue;

  final ProgressDirection progressDirection;

  final double borderWidth;
  final Color borderColor;
  final BorderRadiusGeometry? borderRadius;

  final Color? backgroundColor;
  final Color? progressColor;

  final String? label;
  final TextStyle? labelStyle;

  final int animationDuration;

  ProgressBarWidget({
    Key? key,
    required this.maxValue,
    this.barHeight = 5.0,
    this.currentValue = 0,
    this.progressDirection = ProgressDirection.leftToRight,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.green,
    this.label,
    this.labelStyle,
    this.borderWidth = 1.0,
    this.borderColor = Colors.white,
    this.borderRadius,
    this.animationDuration = 200
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProgressBarWidgetState();
}

class ProgressBarWidgetState extends State<ProgressBarWidget> {
  @override
  Widget build(BuildContext context) {
    double progressPercentage = widget.currentValue <= widget.maxValue ? widget.currentValue / widget.maxValue : 1;
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progressPercentage),
      duration: Duration(milliseconds: widget.animationDuration),
      builder: (context, value, child) {
        return Container(
          height: widget.barHeight,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: widget.borderRadius,
            border: Border.all(color: widget.borderColor, width: widget.borderWidth),
          ),
          child: Stack(
            alignment: widget.progressDirection == ProgressDirection.both
                ? Alignment.center
                : _getAlignment(),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: widget.backgroundColor,
              ),
              Container(
                width: MediaQuery.of(context).size.width * value,
                color: widget.progressColor,
              ),
            ],
          ),
        );
      },
    );
  }

  AlignmentDirectional _getAlignment() {
    if (widget.progressDirection == ProgressDirection.leftToRight) {
      return AlignmentDirectional.topStart;
    } else {
      return AlignmentDirectional.topEnd;
    }
  }
}
