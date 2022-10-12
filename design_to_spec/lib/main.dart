import 'dart:ui';

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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/images/pickaxe.svg',
            semanticsLabel: 'mc pickaxe',
            color: Colors.white,
          ),
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
            // alignment: Alignment.center,
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
                            height: 360,
                            alignment: Alignment.center,
                          ),
                          Column(children: [
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      "THE OAK TREE",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: "RetroComputerCaps",
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
                                    // fontFamily: "RetroComputer",
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ))),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Container(
                                    child: const Text(
                                  "It has the smallest initial space requirement for growth, and along with dark oak trees, it has a chance to drop an apple when a leaf block is destroyed. As with birch trees, an oak tree grown near flowers can generate with a bee nest attached.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    // fontFamily: "RetroComputer",
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
                      height: 610,
                      alignment: Alignment.topCenter,
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: const [
                        ItemCard(
                            'assets/images/planks.png',
                            'Planks are common blocks used as building blocks and in crafting recipes. The are one of the first thigns that a player can craft in Minecraft. Planks are used in many crafting recipes. Doors, fences, fence gates, slabs, stairs, boats, trapdoors, pressure plates, and buttons must be crafted from planks of the same type, and the crafted result depends on the type used. For other products, planks of different types can be mixed freely and the wood types in the product is indeterminate. Crimson and warped planks cannot be used to make boats.',
                            'Planks '),
                        SizedBox(height: 15),
                        ItemCard(
                            'assets/images/stick.png',
                            'Planks are common blocks used as building blocks and in crafting recipes. The are one of the first thigns that a player can craft in Minecraft. Some items, when used, place a block or entity version of themselves into the game world. Put simply, they are an item when in the inventory, and a block when placed. For example, boats turn into an entity when placed, and beds turn into a group of blocks when placed. When selected in the hotbar, items briefly display their names above the HUD.',
                            'Sticks'),
                        SizedBox(height: 15),
                        ItemCard(
                            'assets/images/chest.png',
                            'Planks are common blocks used as building blocks and in crafting recipes. The are one of the first thigns that a player can craft in Minecraft. Some items, when used, place a block or entity version of themselves into the game world. Put simply, they are an item when in the inventory, and a block when placed. For example, boats turn into an entity when placed, and beds turn into a group of blocks when placed. When selected in the hotbar, items briefly display their names above the HUD.',
                            'Chest'),
                        SizedBox(height: 15),
                        ItemCard(
                            'assets/images/stairs.png',
                            'Planks are common blocks used as building blocks and in crafting recipes. The are one of the first thigns that a player can craft in Minecraft. Some items, when used, place a block or entity version of themselves into the game world. Put simply, they are an item when in the inventory, and a block when placed. For example, boats turn into an entity when placed, and beds turn into a group of blocks when placed. When selected in the hotbar, items briefly display their names above the HUD.',
                            'Stairs'),
                      ],
                    ),
                  ]),
                  Stack(alignment: Alignment.center, children: [
                    Container(
                      decoration: const BoxDecoration(color: Color(0xFF35363D)),
                      width: 400,
                      height: 610,
                      alignment: Alignment.topCenter,
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

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

  // ignore: use_key_in_widget_constructors
  const ItemCard(this.url, this.text, this.name);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            child: GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              content: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(name,
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        width: 250,
                        height: 250,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 5, color: Colors.white),
                          color: const Color(0xFF324E44),
                          image: DecorationImage(
                            image: AssetImage(url),
                            scale: 1.5,
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 350,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        text,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: "RetroComputer",
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Close",
                            style: TextStyle(
                              fontFamily: "RetroComputer",
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
              backgroundColor: const Color(0xFF686868),
            ),
          ),
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
                  fontFamily: "RetroComputer",
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        )),
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
              child: SingleChildScrollView(
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: "RetroComputer",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
