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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late String searchUrl =
      'https://api.giphy.com/v1/gifs/search?api_key=${apiKey}={1}&limit=25&offset=0&rating=g&lang=en';
  late String apiKey = 'eNfxv8wrzKUIgLfVh3NPADKR9LrjlcxI&q';
  List itemList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  doSearch();
                },
                child: const Text("search")),
            Expanded(
              child: GridView.builder(
                itemCount: itemList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GridTile(
                    header: Text("Header"),
                    child: Container(
                      child: Image.network(itemList[index]),
                    ),
                    footer: Text("Footer"),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Future doSearch() async {
    print('dosearch');
    String url = searchUrl;
    url = url.replaceAll("{0}", apiKey);
    url = url.replaceAll("{1}", 'dog');
    url = url.replaceAll("{2}", 'cat');

    print(url);
    var respone = await http.get(Uri.parse(url));
    var jData = jsonDecode(respone.body);
    for (int i = 0; i < jData["data"].length; i++) {
      setState(() {
        itemList.add(jData["data"][i]["images"]["original_still"]["url"]);
      });
    }
    print(itemList);
  }
}
