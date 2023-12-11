import 'package:flutter/material.dart';

// LINK LABEL STYLES
const TextStyle defaultLabelStyle = TextStyle(
    color: Colors.white, fontSize: 12, decoration: TextDecoration.none);

const TextStyle defaultCompletedLabelStyle = TextStyle(
    color: Colors.blue, fontSize: 14, decoration: TextDecoration.none);

// NODE LABEL STYLES
const TextStyle defaultNodeLabelStyle = TextStyle(
    color: Colors.grey, fontSize: 12, decoration: TextDecoration.none);

///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////

class StepperWidget extends StatefulWidget {
  final List<String> steps;
  final int currentStep;
  final TextStyle? labelStyle;
  final TextStyle? completedLabelStyle;
  final TextStyle? nodeLabelStyle;
  final Color completedNodeIconColor;
  final Color color;
  final Color completedColor;
  final double linkHeight;
  final Color completedLinkColor;

  const StepperWidget({
    Key? key,
    required this.steps,
    required this.currentStep,
    this.labelStyle = defaultLabelStyle,
    this.completedLabelStyle = defaultCompletedLabelStyle,
    this.nodeLabelStyle = defaultNodeLabelStyle,
    this.color = Colors.white,
    this.completedColor = Colors.blue,
    this.linkHeight = 2,
    this.completedLinkColor = Colors.blue,
    this.completedNodeIconColor = Colors.white,
  })  : assert(steps.length >= 2,
            'The steps list must contain at least 2 values.'),
        assert(
            currentStep >= 0, 'The current step must be greater or equal to 0'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => StepperWidgetState();
}

class StepperWidgetState extends State<StepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(children: _generateSteps());
  }

  List<Widget> _generateSteps() {
    List<Widget> steps = [];
    for (int i = 0; i < widget.steps.length * 2; i++) {
      if (i % 2 == 0) {
        // If index is even, render a node
        if (i < widget.currentStep * 2 - 1) {
          // Render a completed node
          steps.add(StepNode(
            index: (i / 2).round() + 1,
            labelStyle: widget.nodeLabelStyle,
            color: widget.completedColor,
            completedNodeIconColor: widget.completedNodeIconColor,
            completedColor: widget.completedColor,
            isCompleted: true,
          ));
        } else {
          // Render a not completed node
          steps.add(StepNode(
            index: (i / 2).round() + 1,
            color: widget.color,
            completedColor: widget.completedColor,
            completedNodeIconColor: widget.completedNodeIconColor,
            labelStyle: widget.nodeLabelStyle,
            isCompleted: false,
          ));
        }
      } else {
        // If index is odd, render a link
        if (i < widget.currentStep * 2) {
          if (i == widget.currentStep * 2 - 1) {
            steps.add(StepNodeLink(
              label: widget.steps[(i / 2).round() - 1],
              labelStyle: widget.completedLabelStyle,
              isLastLink: i == widget.steps.length * 2 - 2,
              height: widget.linkHeight,
              color: widget.completedLinkColor,
            ));
          } else {
            steps.add(StepNodeLink(
              label: widget.steps[(i / 2).round() - 1],
              labelStyle: widget.labelStyle,
              isLastLink: i == widget.steps.length * 2 - 2,
              height: widget.linkHeight,
              color: widget.completedLinkColor,
            ));
          }
        } else {
          // Render a not completed node link
          steps.add(StepNodeLink(
            label: widget.steps[(i / 2).round() - 1],
            labelStyle: widget.labelStyle,
            isLastLink: i == widget.steps.length * 2 - 1,
            height: widget.linkHeight,
            color: widget.color,
          ));
        }
      }
    }
    return steps;
  }
}

///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////

/// A node in the stepper
class StepNode extends StatelessWidget {
  final int index;
  final Color color;
  final Color completedColor;
  final Color completedNodeIconColor;
  final bool isCompleted;
  final TextStyle? labelStyle;

  const StepNode({
    super.key,
    required this.index,
    required this.labelStyle,
    required this.color,
    required this.completedColor,
    required this.isCompleted,
    required this.completedNodeIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: isCompleted
            ? Icon(
                Icons.check,
                color: completedNodeIconColor,
                size: 15,
              )
            : Text(
                index.toString(),
                style: labelStyle,
              ),
      ),
    );
  }
}

///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////
///////////////////////////////////////

/// A link between two nodes
class StepNodeLink extends StatelessWidget {
  final Color color;
  final double height;
  final String label;
  final TextStyle? labelStyle;
  final bool isLastLink;

  const StepNodeLink(
      {super.key,
      required this.label,
      required this.labelStyle,
      required this.color,
      required this.height,
      required this.isLastLink});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: [
        Expanded(
            child: Text(
          label,
          style: labelStyle,
        )),
        !isLastLink
            ? Expanded(
                child: Container(color: color, height: height),
              )
            : Container(),
      ],
    ));
  }
}
