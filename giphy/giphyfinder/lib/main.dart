import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

List<String> limitList = <String>['10', '20', '40', '80'];
List<String> pageList = [
  "100",
  "200",
  "300",
  "400",
  "500",
  "600",
  "700",
  "800",
  "900"
];

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
      'https://api.giphy.com/v1/gifs/search?api_key=$apiKey={1}&limit={2}&offset={3}&rating=g&lang=en';
  late String apiKey = 'eNfxv8wrzKUIgLfVh3NPADKR9LrjlcxI&q';
  late List itemList = [];
  String dropdownValue = limitList.first;
  String offsetDropdownValue = pageList.first;

  String currentGIFURL = 'https://flutter.dev';

  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  var totalCount = '';
  var currentCount = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      myController.text = 'monkeys';
      doSearch(myController.text, dropdownValue, offsetDropdownValue);
    });
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
                        doSearch(myController.text, dropdownValue,
                            offsetDropdownValue);
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Offset"),
                  ),
                  DropdownButton(
                    value: offsetDropdownValue,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        offsetDropdownValue = value!;
                        doSearch(myController.text, dropdownValue,
                            offsetDropdownValue);
                      });
                    },
                    items:
                        pageList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Showing $totalCount'),
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
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if (_formKey.currentState!.validate()) {
                          doSearch(myController.text, dropdownValue,
                              offsetDropdownValue);
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
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            //currentGIFURL = itemList[index];
                          });
                          inform();
                        },
                        child: GridTile(
                          child: Image.network(itemList[index]),
                        ));
                  },
                ),
              ),
            ],
          ),
        ));
  }

  inform() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyWebView(currentGIFURL)));
  }

  Future doSearch(String input, limit, String pageDropdownValue) async {
    itemList = [];
    // print('dosearch');
    String url = searchUrl;
    url = url.replaceAll("{0}", apiKey);
    url = url.replaceAll("{1}", input);
    url = url.replaceAll("{2}", dropdownValue);
    url = url.replaceAll("{3}", offsetDropdownValue);

    //print(url);

    var respone = await http.get(Uri.parse(url));
    var jData = jsonDecode(respone.body);

    for (int i = 0; i < jData["data"].length; i++) {
      setState(() {
        itemList.add(jData["data"][i]["images"]["downsized"]["url"]);
        totalCount = '${jData["pagination"]["total_count"]}';
      });
    }
  }
}

class MyWebView extends StatelessWidget {
  String url;
  MyWebView(this.url);

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('View GIF'),
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            gestureNavigationEnabled: true,
          );
        }));
  }
}
