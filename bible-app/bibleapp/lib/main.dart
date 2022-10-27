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
        primarySwatch: Colors.red,
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
  String languageDropDownValue = "cmn";

  List<String> bibleParams = <String>['language', 'abbreviation', 'name'];
  List<String> languageList = <String>['eng', 'ara', 'cmn', 'deu'];

  void initState() {
    getBibles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            ElevatedButton(
              child: const Text("call"),
              onPressed: () async {
                getBibles();
              },
            ),
            DropdownButton(
              value: languageDropDownValue,
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  languageDropDownValue = value!;
                });
              },
              items: languageList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
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

    // url = url.replaceAll("{params}", getParams());

    url = url.replaceAll("{language}", "?language=$languageDropDownValue");

    var response = await http.get(Uri.parse(url),
        headers: {"api-key": apiKey, "accept": 'applicaion/json'});

    var jData = jsonDecode(response.body);

    // ignore: avoid_print
    for (var i = 0; i <= jData['data'].length; i++) {
      setState(() {
        bibleList
            .add(BibleButton(jData['data'][i]["name"], jData['data'][i]["id"]));
      });
    }
  }

  String getParams() {
    return '';
  }
}

class BibleButton extends StatelessWidget {
  final String name;
  final String bibleID;
  const BibleButton(this.name, this.bibleID, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: () => {},
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
