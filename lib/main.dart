import 'package:flutter/material.dart';
import 'test.dart';
import 'test2.dart';
// import 'package:image_picker/image_picker.dart';

void main() => runApp(
      MaterialApp(
        home: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // File _image;

    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 120, 20, 120),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/test.jpg',
                width: 100,
                height: 200,
              ),
              SizedBox(height: 45.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: '이메일', border: OutlineInputBorder()),
              ),
              SizedBox(height: 15.0),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: '비밀번호', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text('로그인'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Example()),
                      );
                    },
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    child: Text('취소'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Example2()));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

void getImage() async {
  // var Image = await Image
}
