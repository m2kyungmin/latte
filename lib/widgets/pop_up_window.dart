import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color.fromARGB(255, 254, 250, 251),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
              child: TextField(
                style: const TextStyle(
                  fontSize: 15,
                ),
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '제목을 입력하세요.',
                ),
                keyboardType: TextInputType.text,
                minLines: 1,
              ),
            ),
            const SizedBox(
              height: 20,
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
                    iconSize: 40,
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
                    iconSize: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                  child: IconButton(
                    onPressed: () =>
                        _selectIcon(Icons.sentiment_satisfied, Colors.yellow),
                    icon: const Icon(Icons.sentiment_satisfied),
                    color: _selectedIcon == Icons.sentiment_satisfied
                        ? Colors.yellow
                        : Colors.grey,
                    iconSize: 40,
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
                    iconSize: 40,
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
                    iconSize: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
              child: TextField(
                style: const TextStyle(fontSize: 15),
                controller: contentController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '내용을 입력하세요.',
                ),
                keyboardType: TextInputType.text,
                minLines: 5,
                maxLines: 5,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                InkWell(
                  onTap: getGalleryImage,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    color: const Color.fromARGB(255, 225, 220, 220),
                    height: 110,
                    width: 110,
                    child: const Column(
                      children: [
                        Icon(Icons.add),
                        Text('이미지\n추가'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                const SizedBox(width: 10),
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
                    }
                  },
                  child: const Text('저장하기'),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
