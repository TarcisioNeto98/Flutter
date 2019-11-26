import 'package:flutter/material.dart';
import 'second.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  int _counter = 0;
  double result = 1;

  var number1Controller = new TextEditingController();
  var number2Controller = new TextEditingController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
    title: Text(title,
    style: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
    )),
    subtitle: Text(subtitle),
    leading: Icon(
    icon,
    color: Colors.blue[500],
    ),
 );

  @override
  Widget build(BuildContext context) {
    int _count = 0;
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
      body: Row(
        children: <Widget>[
          Text("Number1:"),
          Container(
          width: 100,
          child: TextField(
            controller: number1Controller,
            keyboardType: TextInputType.number,
          )),
          Text("Number2:"),
          Container(
          width: 100,
          child: TextField(
            controller: number2Controller,
            keyboardType: TextInputType.number,
          )),
          Text("$result")
        ],
      ),
      floatingActionButton: FloatingActionButton(
            /*onPressed: () {//Realiza um calculo de soma
              setState(() {
                result = double.parse(number1Controller.text) +
                double.parse(number2Controller.text);
              });
            },*/
            /*onPressed: () {
              Navigator.push(
              context, MaterialPageRoute (builder: (context) => Second()));
            },
            child: Text("Next"),*/
            onPressed: () {//Vai para outra tela e envia dados.
              Navigator.push(
              context, MaterialPageRoute (builder: (context) => Second(data:
              result.toString())));
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
