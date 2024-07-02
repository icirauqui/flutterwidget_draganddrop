import 'package:flutter/material.dart';
import 'drag_and_drop_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Upload Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('File Upload Demo'),
        ),
        body: const DragAndDropWidget(
          width: 500,
          height: 300,
        ),
      ),
    );
  }
}
