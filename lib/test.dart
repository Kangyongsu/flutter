import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

@override
Widget build(BuildContext context) {
  return GetMaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: Example(),
  );
}

class Post {
  final String? data;

  Post({this.data});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      data: json['data'],
    );
  }
}

class _ExampleState extends State<Example> {
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<Post> fetchPost() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/test'), headers: {
      "Accept": "application/json",
    });
    print('${response.body} body!!!!!!!!!!!!!!!!!!!');
    print('${response.statusCode} body!!!!!!!!!!!!!!!!!!!');
    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      return Post.fromJson(json.decode(response.body));
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.

      throw Exception('Failed to load post');
    }
  }

  Future<Post>? post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
    print(post);
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
                      builder: (context) => FutureBuilder<Post>(
                            future: post,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var post = snapshot.data
                                    as Post; //snapshot의 타입이 AsyncSnapshot<Post> 이므로 POST로타입을 변환시켜야 data를 뽑아 올 수 있음
                                return Text(post.data!);
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }

                              // 기본적으로 로딩 Spinner를 보여줍니다.
                              return CircularProgressIndicator();
                            },
                          ));
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
