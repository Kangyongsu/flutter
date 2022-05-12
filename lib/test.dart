import 'package:flutter/material.dart';
// import 'test.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(
      MaterialApp(
        home: Example(),
      ),
    );

class Example extends StatefulWidget {
  Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState(); // State 생성.
}

class _ExampleState extends State<Example> {
  PickedFile? _image;

  Future _getImage() async {
    var image = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      maxWidth: 640,
      maxHeight: 480,
    );
    setState(() {
      _image = image!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 120),
            child: Center(
                child: _image == null
                    ? Text("no image")
                    : Image.file(File(_image!.path)))),
      ),
    );
  }
}
