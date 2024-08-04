import 'package:flutter/material.dart';
import 'package:mm_operator_detector/mm_operator_detector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              MMOperatorDetector.normalizeInput("+95959428000332"),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              MMOperatorDetector.normalizeInput("+959428000332"),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              MMOperatorDetector.normalizeInput("+9509428000332"),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              MMOperatorDetector.isValidMMPhoneNumber("09428000332").toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              MMOperatorDetector.getTelecomName("+95959428000332").toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              MMOperatorDetector.getPhoneNetworkType("09428000332").toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
