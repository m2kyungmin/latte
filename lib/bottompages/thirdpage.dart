import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ionicons/ionicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';

class ThirdPage extends StatefulWidget {
  //설정 창 클래스
  const ThirdPage({
    super.key,
    required this.NameValue,
    required this.AgeValue,
    required this.EmailValue,
    // required this.ImageValue
  });

  final String NameValue;
  final String AgeValue;
  final String EmailValue;
  // final String ImageValue;

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  bool isSwitched = false;
  bool darkSwitch = false;
  String dropdownValue = '한국어';

  Future<void> _initializePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getInitData();
    _initializePreferences();
  }

  // 알림, 언어변경 버튼
  _save() async {
    // await prefs.setBool('switch', isSwitched);
    // await prefs.setBool('dark', darkSwitch);
    // await prefs.setString('dropdown', dropdownValue);
  }

  getInitData() async {
    // prefs = await SharedPreferences.getInstance();
    // isSwitched = prefs.getBool('switch') ?? false;
    // darkSwitch = prefs.getBool('dark') ?? false;
    // dropdownValue = prefs.getString('dropdown') ?? '';
    setState(() {
      dropdownValue = '한국어';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 242, 243),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    // Text(
                    //   '설정',
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 25,
                    //     fontWeight: FontWeight.bold,
                    //     fontFamily: "AppDesign",
                    //   ),
                    // ),
                    // const SizedBox(
                    //   width: 225,
                    // ),
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => EditThirdPage()),
                    //     );
                    //   },
                    //   icon: Icon(Ionicons.settings),
                    // ),
                  ]),
                ),
                const SizedBox(
                  height: 40,
                ),
                // Text(
                //   "프로필",
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 20,
                //     fontWeight: FontWeight.w500,
                //     fontFamily: "AppDesign",
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const CircleAvatar(
                          radius: 30,
                          // backgroundImage: FileImage(File(widget.ImageValue)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditThirdPage()),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder: (BuildContext context,
                            AsyncSnapshot<SharedPreferences> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final prefs = snapshot.data!;
                            final text = prefs.getString('currenttext') ??
                                'none'; // SharedPreferences에서 'text' 값을 가져옴
                            return Center(
                              child: Text(
                                text,
                                style: const TextStyle(fontSize: 24),
                              ),
                            );
                          } else {
                            return const Center(child: Text('No data found'));
                          }
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       snapshot.getString('text') ?? '',
                          //       style: const TextStyle(
                          //         fontFamily: "AppDesign",
                          //         fontSize: 18,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //     Text(
                          //       widget.AgeValue,
                          //       style: const TextStyle(
                          //         fontFamily: "AppDesign",
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       height: 10,
                          //     ),
                          //   ],
                          // );
                        },
                      ),
                      const Spacer(),
                      FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder: (BuildContext context,
                            AsyncSnapshot<SharedPreferences> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final prefs = snapshot.data!;
                            final text = prefs.getString('currentemail') ??
                                'none'; // SharedPreferences에서 'text' 값을 가져옴
                            return Center(
                              child: Text(
                                text,
                                style: const TextStyle(fontSize: 24),
                              ),
                            );
                          } else {
                            return const Center(child: Text('No data found'));
                          }
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                // Text(
                //   '기본 설정',
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 20,
                //     fontWeight: FontWeight.w500,
                //     fontFamily: "AppDesign",
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.dark_mode,
                          color: Colors.purple.shade100,
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        '다크 모드',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: "MangoDDobak",
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Switch(
                              value: darkSwitch,
                              onChanged: (value) {
                                setState(() {
                                  darkSwitch = value;
                                  _save();
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Ionicons.notifications,
                          color: Colors.pink.shade100,
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        '알림',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: "MangoDDobak",
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                  _save();
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Ionicons.earth,
                          color: Colors.pink.shade200,
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        '언어',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: "MangoDDobak",
                        ),
                      ),
                      const Spacer(),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: Colors.grey),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            _save();
                          });
                        },
                        items: const [
                          DropdownMenuItem<String>(
                            value: '한국어',
                            child: Text(
                              '한국어',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "MangoDDobak",
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'English',
                            child: Text(
                              'English',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "MangoDDobak",
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: '中國語',
                            child: Text(
                              '中國語',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "MangoDDobak",
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: '日本語',
                            child: Text(
                              '日本語',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "MangoDDobak",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class EditThirdPage extends StatefulWidget {
  // 프로필 창 클래스
  const EditThirdPage({super.key});

  @override
  State<EditThirdPage> createState() => _EditThirdPageState();
}

class _EditThirdPageState extends State<EditThirdPage> {
  // String _imagepath = '';
  XFile? _image;

  String gender = 'man';

  late SharedPreferences _prefs;

  // 이름, 나이, 이메일
  String text = '';
  final TextEditingController text_Controller = TextEditingController();

  String age = '';
  final TextEditingController age_Controller = TextEditingController();

  String email = '';
  final TextEditingController email_Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getinitState();
    LoadImage();
  }

  _save() {
    _prefs.setString('genderValue', gender);
    text = text_Controller.text;
    age = age_Controller.text;
    email = email_Controller.text;
    setState(() {
      _prefs.setString('currenttext', text);
      _prefs.setString('currentage', age);
      _prefs.setString('currentemail', email);
    });
  }

  getinitState() async {
    _prefs = await SharedPreferences.getInstance();
    gender = _prefs.getString('genderValue') ?? '';
    setState(() {
      text = _prefs.getString('currenttext') ?? '';
      age = _prefs.getString('currentage') ?? '';
      email = _prefs.getString('currentemail') ?? '';
    });
  }

  Future getGalleryImage() async {
    // 이미지 picker
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void Saveimage(path) async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString('imagepath', path);
  }

  void LoadImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      // _imagepath = saveimage.getString('imagepath') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 242, 243),
        //elevation: 0.0,
        // leading: IconButton(
        //
        //   onPressed: () async {
        //     await Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => ThirdPage(
        //                   NameValue: text,
        //                   AgeValue: age,
        //                   EmailValue: email,
        //                   ImageValue: _imagepath,
        //                 )));
        //   },
        //   icon: Icon(Ionicons.chevron_back_outline),
        // ),
        //

        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: IconButton(
        //       onPressed: () async {
        //         _save();
        //         Saveimage(_image!.path);
        //
        //         await Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => ThirdPage(
        //                   NameValue: text,
        //                   AgeValue: age,
        //                   EmailValue: email,
        //                   ImageValue: _imagepath,
        //                 )));
        //       },
        //       style: IconButton.styleFrom(
        //         backgroundColor: Color(0xFFF05B88),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(15),
        //         ),
        //         fixedSize: Size(60, 50),
        //         elevation: 3,
        //       ),
        //       icon: Icon(
        //         Ionicons.checkmark,
        //         color: Color.fromARGB(255, 239, 239, 239),
        //       ),
        //     ),
        //   ),
        // ],

        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                const SizedBox(
                  width: 280,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: IconButton(
                    onPressed: () async {
                      _save();
                      Navigator.pop(context);
                      //Saveimage(_image!.path);
                      // NameValue = text;
                      // AgeValue:
                      // age;
                      // EmailValue:
                      // email;
                      // ImageValue: _imagepath,

                      // _save();
                      // Saveimage(_image!.path);
                      // print("saveimage");
                      //  await Navigator.push(
                      //    context,
                      //      MaterialPageRoute(
                      //         builder: (BuildContext context) => ThirdPage(
                      //           NameValue: text,
                      //           AgeValue: age,
                      //           EmailValue: email,
                      //           ImageValue: _imagepath,
                      //         )
                      //     )
                      // );
                      //  print("push");
                      // Navigator.of(context).pop();
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFF05B88),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fixedSize: const Size(60, 50),
                      elevation: 3,
                    ),
                    icon: const Icon(
                      Ionicons.checkmark,
                      color: Color.fromARGB(255, 239, 239, 239),
                    ),
                  ),
                ),
              ]),

              // const Text(
              //   '프로필',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 36,
              //     fontWeight: FontWeight.bold,
              //     fontFamily: "AppDesign",
              //   ),
              // ),
              const SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Expanded(
                  //   child: Text(
                  //     '사진',
                  //     style: TextStyle(
                  //       fontSize: 16.0,
                  //       color: Colors.black,
                  //       fontFamily: "AppDesign",
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                      flex: 10,
                      child: Column(
                        children: [
                          _image == null
                              ? const CircleAvatar(
                                  // backgroundImage: FileImage(File(_imagepath)),
                                  radius: 50,
                                )
                              : const CircleAvatar(
                                  // backgroundImage:
                                  //     FileImage(File(_image!.path)),
                                  radius: 50,
                                ),
                          TextButton(
                            onPressed: getGalleryImage,
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                            child: const Text(
                              '사진 변경',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "MangoDDobak",
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      '성별',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontFamily: "MangoDDobak",
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                gender = 'man';
                              });
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: gender == 'man'
                                  ? const Color.fromARGB(255, 242, 154, 147)
                                  : Colors.grey.shade200,
                              fixedSize: const Size(50, 50),
                            ),
                            icon: Icon(
                              Ionicons.male,
                              color:
                                  gender == 'man' ? Colors.white : Colors.black,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                gender = 'woman';
                              });
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: gender == 'woman'
                                  ? const Color.fromARGB(255, 242, 154, 147)
                                  : Colors.grey.shade200,
                              fixedSize: const Size(50, 50),
                            ),
                            icon: Icon(
                              Ionicons.female,
                              color: gender == 'woman'
                                  ? Colors.white
                                  : Colors.black,
                              size: 20,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      '이름',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontFamily: "MangoDDobak",
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          TextField(
                            controller: text_Controller,
                            style: const TextStyle(
                              fontFamily: "MangoDDobak",
                            ),
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFFF48FB1)),
                              ),
                              labelText: '이름을 입력하세요',
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: "MangoDDobak",
                              ),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  text_Controller.clear();
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      '나이',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontFamily: "MangoDDobak",
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          TextField(
                            controller: age_Controller,
                            style: const TextStyle(
                              fontFamily: "MangoDDobak",
                            ),
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFFF48FB1)),
                              ),
                              labelText: '나이를 입력하세요',
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: "MangoDDobak",
                              ),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  age_Controller.clear();
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      '이메일',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontFamily: "MangoDDobak",
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          TextField(
                            controller: email_Controller,
                            style: const TextStyle(
                              fontFamily: "MangoDDobak",
                            ),
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFFF48FB1)),
                              ),
                              labelText: '이메일을 입력하세요',
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: "MangoDDobak",
                              ),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  email_Controller.clear();
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ],
          ),
        )));
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Main 클래스
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ThirdPage(
        NameValue: '',
        AgeValue: '',
        EmailValue: '',
        // ImageValue: '',
      ), // 홈 화면은 설정 창
    );
    //   }),
    // );
  }
}
