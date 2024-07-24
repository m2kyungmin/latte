import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class pop_up_window extends StatefulWidget {
  const pop_up_window({super.key});

  @override
  pop_up_windowState createState() => pop_up_windowState();
}

class pop_up_windowState extends State<pop_up_window> {
  //내용 작성하기
  final controller = TextEditingController();
  int textCounter = 0;

  _printValue() {
    print("_printValue(): ${controller.text}");
    setState(() {
      textCounter = controller.text.length;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_printValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // saveW(var word) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('word', word);
  // }
  // loadW() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? value = prefs.getString('word');
  //   print(value);
  // }

  //이미지, 갤러리 사진 가져오기
  XFile? _image;

  Future getGalleryImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future getCameraImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  // saveP(var pic) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('pic', pic);
  // }
  // loadP() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? value = prefs.getString('pic');
  //   print(value);
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(0, 255, 255, 255),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: Column(
          children: (<Widget>[
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
              child: TextField(
                style: const TextStyle(fontSize: 15),
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '제목을 입력하세요.',
                ),
                keyboardType: TextInputType.text,
                minLines: 1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    child: IconButton(
                      onPressed: () {
                        print('ㅠㅠ');
                      },
                      icon: Icon(Icons.sentiment_dissatisfied),
                      color: Colors.blue,
                      iconSize: 40,
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                    child: IconButton(
                      onPressed: () {
                        print('-_-');
                      },
                      icon: Icon(Icons.sentiment_neutral),
                      color: Colors.orange,
                      iconSize: 40,
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                    child: IconButton(
                      onPressed: () {
                        print('^_^');
                      },
                      icon: Icon(Icons.sentiment_satisfied),
                      color: Color.fromARGB(255, 244, 200, 58),
                      iconSize: 40,
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                    child: IconButton(
                      onPressed: () {
                        print('x.x');
                      },
                      icon: Icon(Icons.sentiment_very_dissatisfied),
                      color: Colors.red,
                      iconSize: 40,
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                    child: IconButton(
                      onPressed: () {
                        print('^u^');
                      },
                      icon: Icon(Icons.sentiment_very_satisfied),
                      color: Colors.green,
                      iconSize: 40,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ), //내용 입력
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
              child: TextField(
                style: const TextStyle(fontSize: 15),
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '내용을 입력하세요.',
                ),
                keyboardType: TextInputType.text,
                minLines: 5,
                maxLines: 5,
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: getGalleryImage,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    color: Colors.grey,
                    height: 110,
                    width: 110,
                    child: Column(
                      children: [
                        Icon(Icons.add),
                        Text(
                          '이미지\n추가',
                        ),
                      ],
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     SharedPreferences prefs = await SharedPreferences.getInstance();
                //     prefs.setString('pic', _image!.path);
                //   },
                //   child: Text("사진 저장"),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     loadP();
                //   },
                //   child: Text("사진 불러오기"),
                // ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('이전 화면으로'),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // pages.add(const DiaryBlock());
                      });
                      // print(pages.length);
                      Navigator.pop(context);
                    },
                    child: const Text('저장하기')),
              ],
            ),
            SizedBox(height: 40),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () async {
            //         SharedPreferences prefs = await SharedPreferences.getInstance();
            //         prefs.setString('word', controller.text);
            //       },
            //       child: Text("내용 저장"),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {
            //         loadW();
            //       },
            //       child: Text("내용 불러오기"),
            //     )
            //   ],
            // ),
          ]),
        ),
      ),
    );
  }
}
