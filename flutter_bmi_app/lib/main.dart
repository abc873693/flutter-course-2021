import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
  final weight = TextEditingController();
  final height = TextEditingController();
  double bmi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: height,
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: weight,
            ),
            Text('BMI = ${bmi ?? '尚未計算'}'),
            TextButton(
              onPressed: () {
                double h = double.tryParse(height.text);
                double w = double.tryParse(weight.text);
                if (h == null || w == null) {
                  print('格式錯誤');
                } else {
                  h /= 100.0;
                  setState(() {
                    bmi = w / (h * h);
                  });
                }
              },
              child: Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }
}
