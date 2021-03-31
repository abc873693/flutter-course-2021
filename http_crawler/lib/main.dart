import 'package:flutter/material.dart';
import 'package:http_crawler/api/helper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/news.dart';

void main() {
  runApp(MyApp());
}

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<News> data;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('教務處最新消息'),
      ),
      body: data == null
          ? CircularProgressIndicator()
          : ListView.separated(
              itemCount: data.length,
              itemBuilder: (_, index) {
                final news = data[index];
                return ListTile(
                  title: Text(news.title),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(news.date),
                      Text(news.department),
                    ],
                  ),
                  onTap: () {
                    launch(news.link);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1.0,
                );
              },
            ),
    );
  }

  void getData() async {
    data = await Helper.getNews();
    setState(() {});
  }
}
