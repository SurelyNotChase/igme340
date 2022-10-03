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
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 400,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 5, color: Colors.white),
                          color: const Color(0xFF324E44),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/oaktree.png'),
                            scale: 3.0,
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.none,
                          ),
                        ),
                        width: 400,
                        height: 400,
                        alignment: Alignment.center,
                      ),
                      Stack(
                        children: [
                          Container(
                            decoration:
                                const BoxDecoration(color: Color(0xFF686868)),
                            width: 400,
                            height: 400,
                            alignment: Alignment.center,
                          ),
                          Column(children: [
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Container(
                                  
                                    child: const Text(
                                  "THE OAK TREE",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: "retro_computer_personal_use",
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ))),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Container(
                                    child: const Text(
                                  "An oak is the most common tree in the game, found in a variety of biomes, available in several variants.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: "retro_computer_personal_use",
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ))),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Container(
                                    child: const Text(
                                  "THE OAK TREE",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: "retro_computer_personal_use",
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ))),
                          ])
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 400,
                  ),
                  Stack(alignment: Alignment.center, children: [
                    Container(
                      decoration: const BoxDecoration(color: Color(0xFF35363D)),
                      width: 400,
                      height: 480,
                      alignment: Alignment.center,
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: const [
                        ItemCard('assets/images/planks.png',
                            'Planks are common blocks used as building blocks and in crafting recipes. The are one of the first thigns that a player can craft in Minecraft.',
                            'Planks'),
                        SizedBox(height: 15),
                        ItemCard('assets/images/stick.png',
                            'Planks are common blocks used as building blocks and in crafting recipes. The are one of the first thigns that a player can craft in Minecraft.',
                            'Sticks'),
                        SizedBox(height: 15),
                        ItemCard('assets/images/chest.png',
                            'Planks are common blocks used as building blocks and in crafting recipes. The are one of the first thigns that a player can craft in Minecraft.','Chest'),
                      SizedBox(height: 15),
                        ItemCard('assets/images/stairs.png',
                            'Planks are common blocks used as building blocks and in crafting recipes. The are one of the first thigns that a player can craft in Minecraft.','Stairs')
                      
                      ],
                    ),
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String url;
  final String text;
  final String name;

  const ItemCard(this.url, this.text,this.name);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Container(
              width: 140,
              height: 140,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 5, color: Colors.white),
                color: const Color(0xFF324E44),
                image: DecorationImage(
                  image: AssetImage(url),
                  scale: 3.0,
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.none,
                ),
              ),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: Container(
              width: 240,
              height: 140,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xFF686868),
              ),
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: "retro_computer_personal_use",
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
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