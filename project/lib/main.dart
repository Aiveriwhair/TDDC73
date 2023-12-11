import 'package:flutter/material.dart';
import 'package:loading_bar_widget/widgets/pass_strenght_meter_widget.dart';

void main() {
  runApp(const AppTest());
}

class AppTest extends StatefulWidget {
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
            Expanded(child: PasswordStrMeterWidget()),
          ],
        ))
        // const Text("PROGRESS BAR"),
        // ProgressBarWidget(
        //   progressDirection: ProgressDirection.rightToLeft,
        //     maxValue: 100,
        //   barHeight: 20,
        //   currentValue: currentValue,
        // ),
        // ElevatedButton(onPressed: (){
        //   setState(() {
        //     currentValue+=10;
        //   });
        // }, child: Text("Incr moi wesh")),
        // const Text("Steps left"),
        // StepsLeftWidget(steps: const ["Order placed", "In review", "Approval", "End"], currentStep: 3)
        );
  }
}
