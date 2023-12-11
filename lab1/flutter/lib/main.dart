import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab1_Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: MyFlutterPage(title: 'Example 1'),
      ),
    );
  }
}

class MyFlutterPage extends StatelessWidget {
  String title = "";
  MyFlutterPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          titleTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
          ),
          title: Text(title),
        ),
        body: LayoutBuilder(builder: (ctx, constraints) {
          return Container(
              height: constraints.maxHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        child: const Image(
                            image:
                                AssetImage('assets/images/subjects_wheel.png'),
                            height: 150)),
                    Container(child: const FourButtonsWidget()),
                  ],
                ),
              ));
        }));
  }
}

class MyButtonWidget extends StatelessWidget {
  String buttonTitle = "";
  MyButtonWidget({super.key, required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            backgroundColor: Colors.grey,
            elevation: 0,
          ),
          child: Text(
            buttonTitle,
            style: const TextStyle(color: Colors.black),
          ),
        ));
  }
}

class FourButtonsWidget extends StatelessWidget {
  const FourButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyButtonWidget(buttonTitle: "BUTTON"),
            MyButtonWidget(buttonTitle: "BUTTON"),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          MyButtonWidget(buttonTitle: "BUTTON"),
          MyButtonWidget(buttonTitle: "BUTTON"),
        ]),
      ],
    ));
  }
}

class MyInputTextWidget extends StatelessWidget {
  const MyInputTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          "Email",
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(
            width: 250,
            height: 50,
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your username',
              ),
            ))
      ],
    ));
  }
}
