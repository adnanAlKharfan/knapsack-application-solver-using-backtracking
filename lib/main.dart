import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'backtracking',
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
      home: MyHomePage(title: 'bactrack'),
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
  List<TextEditingController> w = new List();
  List<TextEditingController> v = new List();
  TextEditingController size = TextEditingController();

  int max = 0;
  GlobalKey<FormState> key = new GlobalKey<FormState>();
  List temp = new List();
  backtrack(int size) {
    if (size == 0) {
      int sum = 0;
      temp.forEach((element) {
        sum += element;
      });
      if (max < sum) {
        max = sum;
      }
    }

    if (size >= 0) {
      for (int i = 0; i < w.length; i++) {
        temp.add(int.parse(v[i].text));
        backtrack(size - int.parse(w[i].text));
        temp.removeLast();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomSheet: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
              color: Colors.blue,
              child: Text("solve"),
              onPressed: () {
                if (size != null) {
                  key.currentState.save();
                  max = 0;
                  backtrack(int.parse(size.text));

                  setState(() {});
                }
              })),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Wrap(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Form(
                key: key,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: TextField(
                                  controller: w[index],
                                  onSubmitted: (value) {
                                    v[index].text = v[index].text.trim();
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: "weight",
                                      hasFloatingPlaceholder: false,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                )),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: TextField(
                                    controller: v[index],
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (value) {
                                      v[index].text = v[index].text.trim();
                                    },
                                    decoration: InputDecoration(
                                        labelText: "value",
                                        hasFloatingPlaceholder: false,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)))))
                          ],
                        ));
                  },
                  itemCount: w.length,
                ))),
        IconButton(
            onPressed: () {
              setState(() {
                TextEditingController temp = new TextEditingController();
                TextEditingController temp1 = new TextEditingController();
                w.add(temp);
                v.add(temp1);
              });
            },
            icon: Icon(Icons.add)),
        IconButton(
            onPressed: () {
              setState(() {
                w.removeLast();
                v.removeLast();
              });
            },
            icon: Icon(Icons.delete)),
        Center(
            child: Column(
          children: [
            Icon(
              Icons.backpack,
              size: MediaQuery.of(context).size.aspectRatio * 50,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: TextField(
                    controller: size,
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) {
                      size.text = size.text.trim();
                    },
                    decoration: InputDecoration(
                        labelText: "size",
                        hasFloatingPlaceholder: false,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)))))
          ],
        )),
        SizedBox(
          height: 10.0,
        ),
        Text("the maxium value: $max")
      ]),
    );
  }
}
