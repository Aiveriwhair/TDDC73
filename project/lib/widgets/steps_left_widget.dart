import 'package:flutter/material.dart';

const TextStyle defaultLabelStyle = TextStyle(
    color: Colors.blue, fontSize: 16, decoration: TextDecoration.none);
const TextStyle defaultCompletedLabelStyle = TextStyle(
    color: Colors.white, fontSize: 16, decoration: TextDecoration.none);

class StepsLeftWidget extends StatefulWidget {
  final List<String> steps;
  final int currentStep;
  final List<IconData>? icons;
  final bool showLabel;
  final TextStyle? labelStyle;
  final TextStyle? labelStyleComplete;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double linkWidth;
  final double linkHeight;

  const StepsLeftWidget({
    Key? key,
    required this.steps,
    required this.currentStep,
    this.linkWidth = 40,
    this.linkHeight = 10,
    this.icons,
    this.showLabel = false,
    this.labelStyle = defaultLabelStyle,
    this.labelStyleComplete = defaultCompletedLabelStyle,
    this.color = Colors.white,
    this.borderColor = Colors.blue,
    this.borderWidth = 4.0,
  })  : assert(steps.length >= 2,
            'The steps list must contain at least 2 values.'),
        assert(
            currentStep >= 0, 'The current step must be greater or equal to 0'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => StepsLeftWidgetState();
}

class StepsLeftWidgetState extends State<StepsLeftWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.steps.length * 2 - 1,
          itemBuilder: (BuildContext context, int index) {
            if (index % 2 == 0) {
              // If index is even, render a node
              if (index < widget.currentStep * 2 - 1) {
                // Render a completed node
                return StepNode(
                    borderColor: widget.borderColor,
                    borderWidth: widget.borderWidth,
                    label: ((index / 2).round()).toString(),
                    color: widget.borderColor,
                    labelStyle: widget.labelStyleComplete);
              } else {
                // Render a not completed node
                return StepNode(
                  borderColor: widget.borderColor,
                  borderWidth: widget.borderWidth,
                  label: ((index / 2).round()).toString(),
                  labelStyle: widget.labelStyle,
                  color: widget.color,
                );
              }
            } else {
              // If index is odd, render a link
              if (index < widget.currentStep * 2) {
                return StepNodeLink(
                  // Render a completed node link
                  borderColor: widget.borderColor,
                  borderWidth: widget.borderWidth,
                  width: widget.linkWidth, height: widget.linkHeight,
                  color: widget.borderColor,
                );
              } else {
                // Render a not completed node link
                return StepNodeLink(
                  borderColor: widget.borderColor,
                  borderWidth: widget.borderWidth,
                  width: widget.linkWidth,
                  height: widget.linkHeight,
                  color: widget.color,
                );
              }
            }
          },
        ));
  }
}

class StepNode extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final String label;
  final TextStyle? labelStyle;

  const StepNode(
      {super.key,
      required this.borderColor,
      required this.borderWidth,
      required this.label,
      this.labelStyle,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
            child: Text(
          label,
          style: labelStyle,
        )));
  }
}

class StepNodeLink extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double width;
  final double height;

  const StepNodeLink(
      {super.key,
      required this.borderColor,
      required this.borderWidth,
      required this.width,
      required this.color,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:5),
      height: height,
      width: width,
      child: Center(
        child: Container(
          constraints: BoxConstraints.expand(height: height),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(width: borderWidth, color: borderColor),
          ),
        ),
      ),
    );
  }
}

