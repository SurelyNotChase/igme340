// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
      home: const MyHomePage(title: 'Bible App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String searchUrl = 'https://api.scripture.api.bible/v1/bibles{language}';
  late String apiKey = 'a2659cf791469685d502c666d9ca0ad4';
  late List<Widget> bibleList = [];
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
            DropdownButton(
              value: languageDropDownValue,
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
                  child: Text(value['nativeName']),
                );
              }).toList(),
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

  String getParams() {
    return '';
  }
}

class Bible extends StatelessWidget {
  final String name;
  final String bibleID;
  const Bible(this.name, this.bibleID, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            color: Colors.brown,
            width: 400,
            child: Padding(
                padding: const EdgeInsets.all(8.0), child: Text(name))));
  }
}
