import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<String> limitList = <String>['10', '20', '40', '80'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Giphy Finder'),
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
      'https://api.giphy.com/v1/gifs/search?api_key=$apiKey={1}&limit={2}&offset=0&rating=g&lang=en';
  late String apiKey = 'eNfxv8wrzKUIgLfVh3NPADKR9LrjlcxI&q';
  late List itemList = [];
  String dropdownValue = limitList.first;
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter some text!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter search term",
                      border: OutlineInputBorder()),
                  controller: myController,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Limit results"),
                  ),
                  DropdownButton(
                    value: dropdownValue,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items:
                        limitList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text("search"),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          doSearch(myController.text, dropdownValue);
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text("reset"),
                      onPressed: () {
                        setState(() {
                          itemList = [];
                          dropdownValue = '10';
                          myController.text = '';
                        });
                      },
                    ),
                  ),
                ],
              ),
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
                      child: Image.network(itemList[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Future doSearch(String input, limit) async {
    itemList = [];
    // print('dosearch');
    String url = searchUrl;
    url = url.replaceAll("{0}", apiKey);
    url = url.replaceAll("{1}", input);
    url = url.replaceAll("{2}", dropdownValue);

    //print(url);

    var respone = await http.get(Uri.parse(url));
    var jData = jsonDecode(respone.body);
    // print(jData);
    for (int i = 0; i < jData["data"].length; i++) {
      setState(() {
        itemList.add(jData["data"][i]["images"]["downsized"]["url"]);
      });
    }
    // print(jData);
    //print(itemList);
  }
}
