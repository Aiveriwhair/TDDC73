import 'package:flutter/material.dart';
import 'package:loading_bar_widget/widgets/pass_strenght_meter_widget.dart';
import 'package:loading_bar_widget/widgets/progress_bar_widget.dart';
import 'package:loading_bar_widget/widgets/stepper_widget.dart';

void main() {
  runApp(const AppTest());
}

class AppTest extends StatefulWidget {
  const AppTest({super.key});

  @override
  State<StatefulWidget> createState() => AppTestState();
}

class AppTestState extends State<AppTest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Progress bar library',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.black, secondary: Colors.white),
          useMaterial3: true,
        ),
        home: SafeArea(
            child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text("Password strength meter",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        decoration: TextDecoration.none))),
            Padding(
                padding: const EdgeInsets.all(20),
                child: PasswordStrMeterWidget()),
            const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text("Steps lefts",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        decoration: TextDecoration.none))),
            StepperWidget(steps: ["Order", "Sent", "Arrived"], currentStep: 1)
          ],
        )));
  }
}
