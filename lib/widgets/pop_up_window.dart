import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latte/size_config.dart';

class pop_up_window extends StatefulWidget {
  const pop_up_window({super.key});

  @override
  pop_up_windowState createState() => pop_up_windowState();
}

class pop_up_windowState extends State<pop_up_window> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  XFile? _image;
  IconData? _selectedIcon;
  Color _iconColor = Colors.grey;

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

  void _selectIcon(IconData icon, Color color) {
    setState(() {
      _selectedIcon = icon;
      _iconColor = color;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: getProportionateScreenHeight(550),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color.fromARGB(255, 254, 250, 251),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: getProportionateScreenHeight(40)),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
              child: TextField(
                style: TextStyle(
                  fontSize: getProportionateFontSize(15),
                ),
                controller: titleController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: getProportionateScreenHeight(1),
                        color: Color(0xFFF48FB1)),
                  ),
                  border: OutlineInputBorder(),
                  hintText: '제목을 입력하세요.',
                ),
                keyboardType: TextInputType.text,
                minLines: 1,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: IconButton(
                    onPressed: () =>
                        _selectIcon(Icons.sentiment_dissatisfied, Colors.blue),
                    icon: const Icon(Icons.sentiment_dissatisfied),
                    color: _selectedIcon == Icons.sentiment_dissatisfied
                        ? Colors.blue
                        : Colors.grey,
                    iconSize: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                  child: IconButton(
                    onPressed: () =>
                        _selectIcon(Icons.sentiment_neutral, Colors.orange),
                    icon: const Icon(Icons.sentiment_neutral),
                    color: _selectedIcon == Icons.sentiment_neutral
                        ? Colors.orange
                        : Colors.grey,
                    iconSize: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                  child: IconButton(
                    onPressed: () => _selectIcon(Icons.sentiment_satisfied,
                        Color.fromARGB(255, 237, 203, 13)),
                    icon: const Icon(Icons.sentiment_satisfied),
                    color: _selectedIcon == Icons.sentiment_satisfied
                        ? Color.fromARGB(255, 237, 203, 13)
                        : Colors.grey,
                    iconSize: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                  child: IconButton(
                    onPressed: () => _selectIcon(
                        Icons.sentiment_very_dissatisfied, Colors.red),
                    icon: const Icon(Icons.sentiment_very_dissatisfied),
                    color: _selectedIcon == Icons.sentiment_very_dissatisfied
                        ? Colors.red
                        : Colors.grey,
                    iconSize: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                  child: IconButton(
                    onPressed: () => _selectIcon(
                        Icons.sentiment_very_satisfied, Colors.green),
                    icon: const Icon(Icons.sentiment_very_satisfied),
                    color: _selectedIcon == Icons.sentiment_very_satisfied
                        ? Colors.green
                        : Colors.grey,
                    iconSize: 35,
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
              child: TextField(
                style: TextStyle(fontSize: getProportionateFontSize(15)),
                controller: contentController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: getProportionateScreenHeight(1),
                        color: Color(0xFFF48FB1)),
                  ),
                  border: OutlineInputBorder(),
                  hintText: '내용을 입력하세요.',
                ),
                keyboardType: TextInputType.text,
                minLines: 5,
                maxLines: 5,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            // Row(
            //   children: [
            //     InkWell(
            //       onTap: getGalleryImage,
            //       child: Container(
            //         padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            //         margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            //         color: const Color.fromARGB(255, 225, 220, 220),
            //         height: getProportionateScreenHeight(130),
            //         width: getProportionateScreenWidth(110),
            //         child: const Column(
            //           children: [
            //             Icon(Icons.add),
            //             Text('이미지\n추가'),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 253, 179, 208),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('이전 화면으로'),
                ),
                SizedBox(width: getProportionateScreenWidth(10)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 253, 179, 208),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        contentController.text.isNotEmpty &&
                        _selectedIcon != null) {
                      Navigator.pop(context, {
                        'title': titleController.text,
                        'content': contentController.text,
                        'icon': _selectedIcon!.codePoint.toString(),
                        'iconColor': _iconColor.value.toString(),
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              '모든 항목을 입력해주세요.',
                              style: TextStyle(fontSize: 15),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  '확인',
                                  style: TextStyle(color: Color(0xFFF05B88)),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('저장하기'),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
          ],
        ),
      ),
    );
  }
}
