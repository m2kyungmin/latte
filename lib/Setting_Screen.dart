import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latte/size_config.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';

class AccountScreen extends StatefulWidget {
  //설정 창 클래스
  const AccountScreen(
      {super.key,
      required this.NameValue,
      required this.AgeValue,
      required this.EmailValue,
      required this.ImageValue});

  final String NameValue;
  final String AgeValue;
  final String EmailValue;
  final String ImageValue;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late SharedPreferences prefs;
  bool isSwitched = false;
  String dropdownValue = '한국어';

  // 알림, 언어변경 버튼
  _save() async {
    await prefs.setBool('switch', isSwitched);
    await prefs.setString('dropdown', dropdownValue);
  }

  getInitData() async {
    prefs = await SharedPreferences.getInstance();
    isSwitched = prefs.getBool('switch') ?? false;
    dropdownValue = prefs.getString('dropdown') ?? '';
    setState(() {
      dropdownValue = '한국어';
    });
  }

  @override
  void initState() {
    super.initState();
    getInitData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(225, 246, 242, 243),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    const Text(
                      '설정',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(225),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditAccountScreen()),
                        );
                      },
                      icon: const Icon(Ionicons.settings),
                    ),
                  ]),
                ),

                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                const Text(
                  "프로필",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(File(widget.ImageValue)),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(20),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.NameValue,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            widget.AgeValue,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        widget.EmailValue,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // GestureDetector(
                      //     onTap: () {
                      //       Navigator.pop(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => EditAccountScreen()),
                      //       );
                      //     },
                      //     child: Container(
                      //       width: 60,
                      //       height: 60,
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey.shade200,
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //       child: const Icon(Ionicons.chevron_forward_outline),
                      //     )),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                const Text(
                  '기본 설정',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                // Container(
                //   width: double.infinity,
                //   child: Row(
                //     children: [
                //       Container(
                //         height: 50,
                //         width: 50,
                //         decoration: BoxDecoration(
                //             shape: BoxShape.circle, color: Colors.red.shade200),
                //         child: Icon(
                //           Icons.dark_mode,
                //           color: Colors.red,
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 20,
                //       ),
                //       Text(
                //         '다크 모드',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 16.0,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //       const Spacer(),
                //       const SizedBox(
                //         width: 20,
                //       ),
                //       Consumer<UiProvider>(
                //         builder: (context, UiProvider notifier, child) {
                //           return GestureDetector(
                //             onTap: () {},
                //             child: Container(
                //               width: 60,
                //               height: 60,
                //               child: Switch(
                //                 value: notifier.isDark,
                //                 onChanged: (value) {
                //                   notifier.changeTheme();
                //                 },
                //               ),
                //             ),
                //           );
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        height: getProportionateScreenHeight(50),
                        width: getProportionateScreenWidth(50),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.shade200),
                        child: const Icon(
                          Ionicons.notifications,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(20),
                      ),
                      const Text(
                        '알림',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: getProportionateScreenWidth(20),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: getProportionateScreenWidth(60),
                          height: getProportionateScreenHeight(60),
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
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        height: getProportionateScreenHeight(50),
                        width: getProportionateScreenWidth(50),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange.shade200),
                        child: const Icon(
                          Ionicons.earth,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(20),
                      ),
                      const Text(
                        '언어',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: Colors.grey),
                        underline: Container(
                          height: getProportionateScreenHeight(2),
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
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'English',
                            child: Text(
                              'English',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: '中國語',
                            child: Text(
                              '中國語',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: '日本語',
                            child: Text(
                              '日本語',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(20),
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

class EditAccountScreen extends StatefulWidget {
  // 프로필 창 클래스
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  String _imagepath = '';
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
    setState(() {
      text = text_Controller.text;
      _prefs.setString('currenttext', text);
      age = age_Controller.text;
      _prefs.setString('currentage', age);
      email = email_Controller.text;
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
      _imagepath = saveimage.getString('imagepath') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(225, 246, 242, 243),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountScreen(
                            NameValue: text,
                            AgeValue: age,
                            EmailValue: email,
                            ImageValue: _imagepath,
                          )));
            },
            icon: const Icon(Ionicons.chevron_back_outline),
          ),
          leadingWidth: getProportionateScreenWidth(80),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  _save();
                  Saveimage(_image!.path);
                },
                style: IconButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 245, 200, 218),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fixedSize: const Size(60, 50),
                  elevation: 3,
                ),
                icon: const Icon(
                  Ionicons.checkmark,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '프로필',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      '사진',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 10,
                      child: Column(
                        children: [
                          _image == null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(File(_imagepath)),
                                  radius: 50,
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      FileImage(File(_image!.path)),
                                  radius: 50,
                                ),
                          TextButton(
                            onPressed: getGalleryImage,
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.lightBlueAccent,
                            ),
                            child: const Text(
                              '사진 변경',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      '성별',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
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
                                  ? Colors.deepPurple
                                  : Colors.grey.shade200,
                              fixedSize: const Size(50, 50),
                            ),
                            icon: Icon(
                              Ionicons.male,
                              color:
                                  gender == 'man' ? Colors.white : Colors.black,
                              size: 18,
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(20),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                gender = 'woman';
                              });
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: gender == 'woman'
                                  ? Colors.deepPurple
                                  : Colors.grey.shade200,
                              fixedSize: const Size(50, 50),
                            ),
                            icon: Icon(
                              Ionicons.female,
                              color: gender == 'woman'
                                  ? Colors.white
                                  : Colors.black,
                              size: 18,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      '이름',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          TextField(
                            controller: text_Controller,
                            decoration: InputDecoration(
                              labelText: '이름을 입력하세요',
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
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      '나이',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          TextField(
                            controller: age_Controller,
                            decoration: InputDecoration(
                              labelText: '나이를 입력하세요',
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
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      '이메일',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          TextField(
                            controller: email_Controller,
                            decoration: InputDecoration(
                              labelText: '이메일을 입력하세요',
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

class UiProvider extends ChangeNotifier {
  // 다크 모드
  bool _isDark = false;
  bool get isDark => _isDark;
  late SharedPreferences storage;

  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black12,
  );

  final lightTheme = ThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.light,
      primaryColorDark: Colors.white);

  changeTheme() {
    _isDark = !isDark;
    storage.setBool('isDark', _isDark);
    notifyListeners();
  }

  init() async {
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool('isDark') ?? false;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  // Main 클래스
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UiProvider()..init(),
      child:
          Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
            useMaterial3: true,
          ),
          home: const AccountScreen(
            NameValue: '',
            AgeValue: '',
            EmailValue: '',
            ImageValue: '',
          ), // 홈 화면은 설정 창
        );
      }),
    );
  }
}
