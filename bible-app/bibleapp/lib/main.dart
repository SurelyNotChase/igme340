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
      home: const MyHomePage(title: 'not Giphy Finder'),
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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ElevatedButton(
            child: Text("reset"),
            onPressed: () async {
              doSearch('text', 'text');
            },
          ),
        ],
      ),
    );
  }

  Future doSearch(String input, limit) async {
    // print('dosearch');
    String url = searchUrl;
    // url = url.replaceAll("{0}", apiKey);
    // url = url.replaceAll("{1}", input);

    var client = http.Client();
    try {
      var response = await client.post(
          Uri.https('https://api.scripture.api.bible', '/v1/bibles'),
          headers: {'api-key': 'a2659cf791469685d502c666d9ca0ad4'});
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      var uri = Uri.parse(decodedResponse['uri'] as String);
      print(await client.get(uri));
    } finally {
      client.close();
    }

    var respone = await http.get(Uri.parse(url));

    var jData = jsonDecode(respone.body);
  }
}
