import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:luiszambranoayncroniaa/services/mockapi.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practica asincronia en flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: const MyHomePage(title: 'Practica asincronia en flutter'),
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
  double _containerWidth = 0;
  double _containerHeigth = 0;
  Color _containerColor = Colors.blue;

  double _containerWidth1 = 0;
  double _containerHeigth1 = 0;
  Color _containerColor1 = Colors.red;

  double _containerWidth2 = 0;
  double _containerHeigth2 = 0;
  Color _containerColor2 = Colors.black;
  //BorderRadiusGeometry _containerBorederRadius = BorderRadius.circular(8);

  void _animateContainer() {
    final random = Random(2);
    setState(() {
      _containerWidth = random.nextInt(200).toDouble();
      _containerHeigth = random.nextInt(200).toDouble();
    });
  }

  void _animateContainer1() {
    final random1 = Random(2);
    setState(() {
      _containerWidth1 = random1.nextInt(200).toDouble();
      _containerHeigth1 = random1.nextInt(200).toDouble();
    });
  }

  void _animateContainer2() {
    final random2 = Random(2);
    setState(() {
      _containerWidth2 = random2.nextInt(200).toDouble();
      _containerHeigth2 = random2.nextInt(200).toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    int _counter = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<int>(
              future: MockApi().getFerrariInteger(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: const TextStyle(fontSize: 20),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () async {
                var result = await MockApi().getFerrariInteger();
                _animateContainer();
                _counter = result;
                print('Ferrari: $result');
              },
              child: const Icon(
                Icons.offline_bolt,
                size: 50,
                textDirection: TextDirection.ltr,
                color: Colors.white,
              ),
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: _containerWidth,
              height: _containerHeigth,
              color: _containerColor,
            ),
            FutureBuilder<int>(
              future: MockApi().getHyundaiInteger(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: const TextStyle(fontSize: 20),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () async {
                var result = await MockApi().getHyundaiInteger();
                _animateContainer1();
                setState(() {
                  _counter = result;
                  print('Hyundai: $result');
                });
              },
              child: const Icon(Icons.airport_shuttle, size: 50),
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: _containerWidth1,
              height: _containerHeigth1,
              color: _containerColor1,
            ),
            const SizedBox(height: 20),
            FutureBuilder<int>(
              future: MockApi().getFisherPriceInteger(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: const TextStyle(fontSize: 20),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                var result = await MockApi().getFisherPriceInteger();
                _animateContainer2();
                setState(() {
                  _counter = result;
                  print('Fisher Price: $result');
                });
              },
              //person running
              child: const Icon(Icons.directions_run, size: 50),
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: _containerWidth2,
              height: _containerHeigth2,
              color: _containerColor2,
            ),
          ],
        ),
      ),
    );
  }
}
