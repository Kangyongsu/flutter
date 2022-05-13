import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Example2 extends StatefulWidget {
  @override
  _Example2State createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  XFile? _imageFile;

  final ImagePicker _picker = ImagePicker();

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
              imageProfile(),
              SizedBox(
                height: 20,
              )
              // nameTextField(),
              // SizedBox(height: 20,)
            ],
          )),
    );
  }

  Widget imageProfile() {
    File? file = File(_imageFile!.path);

    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
              radius: 80,
              backgroundImage: _imageFile == null
                  ? AssetImage('assets/test.jpg') as ImageProvider
                  : FileImage(file)),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => bottomSheet()));
              },
              child: Icon(Icons.camera_alt, color: Colors.blue, size: 40),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [
        Text('사진선택',
            style: TextStyle(
              fontSize: 20,
            )),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
                onPressed: takePhoto(ImageSource.gallery),
                icon: Icon(Icons.camera, size: 50),
                label: Text('Camera', style: TextStyle(fontSize: 20)))
          ],
        )
      ]),
    );
  }

  takePhoto(ImageSource source) async {
    // final pickedFile = await _picker.getImage(source: source);
    final XFile? pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
