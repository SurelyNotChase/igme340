// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.book_outlined)),
                Tab(icon: Icon(Icons.menu_book)),
                Tab(icon: Icon(Icons.search)),
              ],
            ),
            title: const Text('Bible'),
          ),
          body: const TabBarView(
            children: [
              ChooseBiblePage(title: 'Choose Bible'),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseBiblePage extends StatefulWidget {
  const ChooseBiblePage({super.key, required this.title});
  final String title;
  @override
  State<ChooseBiblePage> createState() => _ChooseBiblePageState();
}

class _ChooseBiblePageState extends State<ChooseBiblePage> {
  late String searchUrl = 'https://api.scripture.api.bible/v1/bibles{language}';
  late String apiKey = 'a2659cf791469685d502c666d9ca0ad4';
  late List<Widget> bibleList = [];
  late Widget bibleDetails;
  String languageDropDownValue = "eng";
  List<String> bibleParams = <String>['language', 'abbreviation', 'name'];
  List<Map> languageList = <Map>[
    {
      'name': 'English',
      'nativeName': 'English',
      'code': 'eng',
    },
    {
      'name': 'Mandarin',
      'nativeName': '中文',
      'code': 'cmn',
    },
    {
      'name': 'Hindi',
      'nativeName': 'हिन्दी ',
      'code': 'hin',
    },
    {
      'name': 'Greek',
      'nativeName': 'ελληνικά',
      'code': 'grc',
    },
    {
      'name': 'Sanskirt',
      'nativeName': 'संस्कृतम् ',
      'code': 'san',
    },
    {
      'name': 'Spanish',
      'nativeName': '	español',
      'code': 'spa',
    },
    {
      'name': 'Portuguese',
      'nativeName': 'português',
      'code': 'por',
    },
    {
      'name': 'German',
      'nativeName': 'Deutsch',
      'code': 'deu',
    },
    {
      'name': 'Ukrainian',
      'nativeName': 'Українська',
      'code': 'ukr',
    }
  ];

  void initState() {
    getBibles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DropdownButton(
                icon: Icon(Icons.language),
                value: languageDropDownValue,
                dropdownColor: Colors.black,
                iconEnabledColor: Colors.white,
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    languageDropDownValue = value!;
                  });
                  getBibles();
                },
                items: languageList.map<DropdownMenuItem<String>>((Map value) {
                  return DropdownMenuItem<String>(
                    value: value['code'],
                    child: Text('${value['nativeName']} (${value['name']})',
                        style: TextStyle(color: Colors.white)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: bibleList,
              ),
            ),
          ),
        ));
  }

  Future getBibles() async {
    String url = searchUrl;

    setState(() {
      bibleList.clear();
    });

    url = url.replaceAll("{language}", "?language=$languageDropDownValue");

    var response = await http.get(Uri.parse(url),
        headers: {"api-key": apiKey, "accept": 'applicaion/json'});

    var jData = jsonDecode(response.body);

    // ignore: avoid_print
    if (jData.length >= 1) {
      for (var i = 0; i <= jData['data'].length - 1; i++) {
        setState(() {
          bibleList
              .add(Bible(jData['data'][i]["name"], jData['data'][i]["id"]));
        });
      }
    }
  }
}

class Bible extends StatefulWidget {
  final String name;
  final String bibleID;
  late Object bibleDetails;
  Bible(this.name, this.bibleID, {super.key});

  @override
  State<Bible> createState() => _BibleState();
}

class _BibleState extends State<Bible> {
  Object bibleDetails = {};
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () {
              getBibleDetails(widget.bibleID);

              showDialog(
                context: context,
                builder: (BuildContext context) => BibleDetailsDialogue(
                    bibleID: widget.bibleID,
                    name: widget.name,
                    bibleData: bibleDetails),
              );
            },
            child: Container(
                width: 400,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          )),
                    ))),
          ),
        ));
  }

  Future getBibleDetails(thisBibleID) async {
    String searchUrl = 'https://api.scripture.api.bible/v1/bibles/{bibleID}';
    String apiKey = 'a2659cf791469685d502c666d9ca0ad4';

    searchUrl = searchUrl.replaceAll("{bibleID}", thisBibleID);

    var response = await http.get(Uri.parse(searchUrl),
        headers: {"api-key": apiKey, "accept": 'applicaion/json'});

    var jData = jsonDecode(response.body);

    setState(() {
      bibleDetails = jData['data'];
    });
  }
}

class BibleDetailsDialogue extends StatelessWidget {
  final String bibleID;
  final String name;
  final bibleData;

  const BibleDetailsDialogue({
    required this.name,
    required this.bibleID,
    required this.bibleData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(bibleData['description']);
    //String description = bibleData['name'];

    return AlertDialog(
        content: SizedBox(
      height: 500,
      child: Column(
        children: [
          Text(name, style: TextStyle(fontSize: 18)),
          Text(bibleID, style: TextStyle(fontSize: 18)),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Title: '),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
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
                      fontSize: 16,
                    ),
                  )),
            ),
          ),
        ],
      ),
    ));
  }
}
