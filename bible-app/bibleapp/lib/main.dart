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
  late String searchUrl = 'https://api.scripture.api.bible/v1/bibles';
  late String apiKey = 'a2659cf791469685d502c666d9ca0ad4';
  late List<Widget> bibleList = [];
  String dropdownValue = "cmn";
  List<String> languageList = <String>['eng','ara','cmn','deu'];

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
              child: Text("call"),
              onPressed: () async {
                getBibles();
              },
            ),
            DropdownButton(
              value: dropdownValue,
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
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
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: bibleList,
            ),
          ),
        ));
  }

  Future getBibles() async {
    String url = searchUrl;
    setState(() {
        bibleList.clear();
      });
    var respone = await http.get(Uri.parse(url), 
    headers: {
      "api-key": apiKey,
      "language":dropdownValue
      });

    var jData = jsonDecode(respone.body);
    // var id = jData[0].data[0].id;

    // ignore: avoid_print
    for (var i = 0; i <= jData['data'].length; i++) {
      setState(() {
        bibleList.add(Text(jData['data'][i]["name"]));
      });
    }
  }
}
