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
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(alignment: Alignment.center, children: [
              Container(
                decoration: BoxDecoration(color: Color(0xFF35363D)),
                width: 400,
                height: 400,
                alignment: Alignment.center,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            width: 140,
                            height: 140,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(width: 5, color: Colors.white),
                              color: const Color(0xFF324E44),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/chest.png'),
                                scale: 3.0,
                                alignment: Alignment.bottomCenter,
                                fit: BoxFit.none,
                              ),
                            ),
                            child: const Text(
                              "Chest",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "retro_computer_personal_use",
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            width: 250,
                            height: 140,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: const Color(0xFF686868),
                            ),
                            child: const Text(
                              "Planks are common blocks used as building blocks and in crafting recipes. The are one of the first thigns that a player can craft in Minecraft.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "retro_computer_personal_use",
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
//child: Padding(padding: const EdgeInsets.all(0),),

                    // const SizedBox(
                    //   width: 200,
                    //   height: 140,
                    //   child: Padding(
                    //     padding: EdgeInsets.all(10),
                    //     child: SizedBox(
                    //       child: Text(
                    //           "Planks are common blocks used as building blocks and in crafting recipes. The are one of the first thigns that a player can craft in Minecraft.",
                    //           style:
                    //               TextStyle(color: Colors.white, fontSize: 16),
                    //           textAlign: TextAlign.center),
                    //     ),
                    //   ),
                    // ),