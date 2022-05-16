import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Example2 extends StatefulWidget {
  @override
  _Example2State createState() => _Example2State();
}

@override
Widget build(BuildContext context) {
  return GetMaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: Example2(),
  );
}

class _Example2State extends State<Example2> {
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  void get() async {
    final url = Uri.parse('http://localhost:5000/');
    final response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  void openBottomSheet() {
    Get.bottomSheet(
      Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Bottom Sheet',
              style: TextStyle(fontSize: 18),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Close'),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("프로필 등록"),
          centerTitle: true,
          backgroundColor: Colors.red,
          leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
          actions: [
            IconButton(icon: Icon(Icons.image), onPressed: null),
            IconButton(icon: Icon(Icons.navigate_next), onPressed: null),
          ]),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: ListView(
            children: [
              imageProfile(context),
              SizedBox(
                height: 20,
              )
              // nameTextField(),
              // SizedBox(height: 20,)
            ],
          )),
    );
  }

  Widget imageProfile(context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
              radius: 80,
              backgroundImage: _imageFile == null
                  ? AssetImage('assets/test.jpg') as ImageProvider
                  : FileImage(_imageFile!)),
          Positioned(
              bottom: 20,
              right: 20,
              child: TextButton(
                style: TextButton.styleFrom(primary: Colors.transparent),
                child: Text("사진변경"),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                    onPressed: () => takePhoto(1),
                                    icon: Icon(Icons.camera, size: 50),
                                    label: Text('Camera',
                                        style: TextStyle(fontSize: 20))),
                                TextButton.icon(
                                    onPressed: () => takePhoto(2),
                                    icon: Icon(Icons.photo_library, size: 50),
                                    label: Text('gallery',
                                        style: TextStyle(fontSize: 20))),
                              ]));
                },
              )),
        ],
      ),
    );
  }

  takePhoto(seq) async {
    // final pickedFile = await _picker.getImage(source: source);
    final XFile? pickedFile;
    if (seq == 1) {
      pickedFile = await _picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile!.path);
      });
    }
  }
}
