import 'package:flutter/material.dart';
import 'package:loading_bar_widget/widgets/progress_bar_widget.dart';
import 'package:loading_bar_widget/widgets/steps_left_widget.dart';

void main() {
  runApp(const AppTest());
}
class AppTest extends StatefulWidget{
  const AppTest({super.key});

  @override
  State<StatefulWidget> createState() => AppTestState();
}

class AppTestState extends State<AppTest> {
 int currentValue = 20;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress bar library',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SafeArea(child: Column(children: [
        const Text("PROGRESS BAR"),
        ProgressBarWidget(
          progressDirection: ProgressDirection.rightToLeft,
            maxValue: 100,
          barHeight: 20,
          currentValue: currentValue,
        ),
        ElevatedButton(onPressed: (){
          setState(() {
            currentValue+=10;
          });
        }, child: Text("Incr moi wesh")),
        const Text("Steps left"),
        StepsLeftWidget(steps: const ["Order placed", "In review", "Approval", "End"], currentStep: 3)
      ])),
    );
  }
}