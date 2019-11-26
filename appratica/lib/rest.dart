import 'dart:convert';

import 'package:flutter/material.dart' ;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/post.dart';
import 'models/user.dart';

void rest() => runApp(Second());
class Second extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
    var itens = new List<Post>();
    Construtor () {
      itens = [];
    }

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
      int _count = 0;
    var userId = new TextEditingController();
    var id = new TextEditingController();
    var title = new TextEditingController();
    var body = new TextEditingController();
    var url = 'https://jsonplaceholder.typicode.com/posts';

  ListTile _tile(String userId, String id, String title, String body) => ListTile(
    title: Row(
      
      mainAxisAlignment: MainAxisAlignment .spaceEvenly,
      children: < Widget>[
        Flexible(
          child: Text(userId),
        ),
        Flexible(
          child: Text(id),
        ),
        Flexible(
          child: Text(title),
        ),
        Flexible(
          child: Text(body),
        ),
      ],
    ),
  );


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
        actions: < Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar' ,
            onPressed: () {
            print("show");
            },
          ),
        ]
      ),
      body: SingleChildScrollView (
        child: Column(
        children: < Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment .spaceEvenly,
            children: < Widget>[
            Flexible(
            child: Text("UserId:"),
            ),
            Flexible(
            child: TextField(
            controller: userId),
            )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment .spaceEvenly,
            children: < Widget>[
              Flexible(
              child: Text("Id:" ),
            ),
            Flexible(
              child: TextField(
              controller: id),
            )
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment .spaceEvenly,
            children: < Widget>[
            Flexible(
            child: Text("Title:"),
            ),
            Flexible(
            child: TextField(
            controller: title),
            )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment .spaceEvenly,
            children: < Widget>[
              Flexible(
              child: Text("Body:" ),
            ),
            Flexible(
              child: TextField(
              controller: body),
            )
            ],
          ),

          RaisedButton (
            onPressed: () async {
              setState(() {
                widget.itens.add(Post(userId: userId.text, id:id.text, title: title.text, body: body.text));
              });
              var prefs = await SharedPreferences.getInstance();
              var data = prefs. getString('data');
              if (data != null) {
                Iterable decoded = jsonDecode (data);
                List<Post> listItens = decoded. map((x) => Post.fromJson(x)).toList();
                setState(() {
                  widget.itens = listItens;
                });
              }
          },
            child: Text("Add"),
          ),
          RaisedButton (

            onPressed: () async {
              final response = await get(url);
              if (response.statusCode == 200) {
                Iterable l = jsonDecode(response.body);
                List<Posts> users = l. map((i) => Posts.fromJson(i)).toList();
                for (var item in users) {
                  if(item.userId == 2){
                    print(item.id);
                  }
                }
              } else {
                throw Exception('Failed - get all' );
              }
          },
            child: Text("Get"),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics (),
            shrinkWrap: true,
            itemCount: widget.itens.length,
            itemBuilder: ( BuildContext ctxt, int index) {
              return _tile(widget.itens[index].userId,
            widget.itens[index].id, widget.itens[index].title, widget.itens[index].body);
          })
        ]
      ),
),
      floatingActionButton: FloatingActionButton(
            /*onPressed: () {//Realiza um calculo de soma
              setState(() {
                result = double.parse(number1Controller.text) +
                double.parse(number2Controller.text);
              });
            },*/
            onPressed: () {
              
            },
            child: Text("Next"),
            //child: Text("Add"),
      ),
      /*raisedButton: RaisedButton(
        onPressed: () {
        Navigator.push(
        context, MaterialPageRoute (builder: (context) => Second()));
        },
        child: Text("Next"),
      ),*/
    );
  }
}