import 'package:flutter/material.dart';
import 'package:latte/widgets/diary_block.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../bottompages/firstpage/firstpage.dart';

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: (<Widget>[
          Center(
            child: _image == null
                ? const Text(
                    '사진을 추가하지 않았습니다.',
                    style: TextStyle(color: Colors.white),
                  )
                : CircleAvatar(
                    backgroundImage: FileImage(File(_image!.path)),
                    radius: 130,
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: getGalleryImage,
                child: const Text('갤러리'),
              ),
              ElevatedButton(
                onPressed: getCameraImage,
                child: const Text('카메라'),
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
              const Text('hello')
            ],
          ),

          //내용 입력
          TextField(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('이전 화면으로'),
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
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // pages = pages.sublist(0, 1);
                    });
                    // print(pages.length);
                    Navigator.pop(context);
                  },
                  child: const Text('초기화')),
            ],
          )
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
    );
  }
}
