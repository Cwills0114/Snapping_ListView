import 'package:flutter/material.dart';
import 'package:snap_demo/listScrollPhysics.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List items = getDummyList();
    ScrollController _scrollController = ScrollController();


    return Scaffold(
        appBar: AppBar(
          title: Text("Snap List View Demo"),
        ),
        body: ListView.builder(
            physics: listScrollPhysics(),
            controller: _scrollController,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  height: 140,
                  child: Text("${items[index]}")),
              );
            }) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  List getDummyList() {
    List list = List.generate(2000, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }
}
