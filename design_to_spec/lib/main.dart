import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design To Spec',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'TREES & WOOD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 50,
        title: Text(style: const TextStyle(color: Colors.white), widget.title),
        leading: SvgPicture.asset(
          'assets/images/pickaxe.svg',
          semanticsLabel: 'mc pickaxe',
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/valley.jpg'),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      width: 385,
                      height: 170,
                      color: Colors.blueGrey,
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            width: 200,
                            height: 200,
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(width: 5, color: Colors.white),
                              color: Colors.blue,
                              image: const DecorationImage(
                                image: AssetImage('assets/images/chest.png'),
                                scale: 3.0,
                                alignment: Alignment.bottomCenter,
                                fit: BoxFit.none,
                              ),
                            ),
                            child: const Text(
                              "Chest",
                              style: TextStyle(
                                fontFamily: "retro_computer_personal_use",
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
//child: Padding(padding: const EdgeInsets.all(0),),