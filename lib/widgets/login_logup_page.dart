import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
 return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

// 로그인 창

class LoginPage extends StatefulWidget{

  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  late SharedPreferences _prefs;

  String Login_ID = "";
  final TextEditingController Login_IDController = TextEditingController();
  String Login_password = "";
  final TextEditingController Login_passwordController = TextEditingController();

  void initState() {
    super.initState();
    getinitState();
  }

  _save() {
    setState(() {
      Login_ID = Login_IDController.text;
      _prefs.setString('currentLogin_ID', Login_ID);
      Login_password = Login_passwordController.text;
      _prefs.setString('currentLogin_password', Login_password);
    });
  }

  getinitState() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      Login_ID = _prefs.getString('currentLogin_ID') ?? '';
      Login_password = _prefs.getString('currentLogin_password') ?? '';
    });
  }

  Widget build(BuildContext context){
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Container(
                padding: EdgeInsets.only(left: 16,right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 50,),
                        Text('환영합니다',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                        SizedBox(height: 6,),
                        Text('로그인 하세요!',style: TextStyle(fontSize: 20,color: Colors.grey.shade400),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        TextField(
                          controller: Login_IDController,
                          decoration: InputDecoration(
                              labelText: '아이디',
                              labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  )
                              )
                          ),
                        ),

                        SizedBox(height: 16,),

                        TextField(
                          controller: Login_passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: '비밀번호',
                              labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  )
                              )
                          ),
                        ),

                        SizedBox(height: 12,),

                        Align(
                          alignment: Alignment.topRight,
                          child: Text('비밀번호 찾기',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                        ),

                        SizedBox(height: 30,),

                        Container(
                          height: 50,
                          width: double.infinity,
                          child: TextButton(
                            onPressed: (){
                              _save();
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xffff5f6d),
                                    Color(0xffff5f6d),
                                    Color(0xffffc371),
                                  ],
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints(maxWidth: double.infinity,minHeight: 50),
                                child: Text('로그인',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),

                              ),
                            ),
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(6)
                            // ),
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("새로운 멤버 ",style: TextStyle(fontWeight: FontWeight.bold),),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                            },
                            child: Text("회원가입.",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

// 회원가입 창

class SignupPage extends StatefulWidget{

  State<SignupPage> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {

  late SharedPreferences _prefs;

  String Logup_Name = "";
  final TextEditingController Logup_NameController = TextEditingController();
  String Logup_ID = "";
  final TextEditingController Logup_IDController = TextEditingController();
  String Logup_password = "";
  final TextEditingController Logup_passwordController = TextEditingController();

  void initState() {
    super.initState();
    getinitState();
  }

  _save() {
    setState(() {
      Logup_Name = Logup_NameController.text;
      _prefs.setString('currentLogin_ID', Logup_Name);
      Logup_ID = Logup_IDController.text;
      _prefs.setString('currentLogin_ID', Logup_ID);
      Logup_password = Logup_passwordController.text;
      _prefs.setString('currentLogin_password', Logup_password);
    });
  }

  getinitState() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      Logup_Name = _prefs.getString('currentLogup_Name') ?? '';
      Logup_ID = _prefs.getString('currentLogup_ID') ?? '';
      Logup_password = _prefs.getString('currentLogup_password') ?? '';
    });
  }


  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50,),
                    Text("회원가입",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                    SizedBox(height: 6,),
                    Text('회원가입 하세요!',style: TextStyle(fontSize: 20,color: Colors.grey.shade400),),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: Logup_NameController,
                      decoration: InputDecoration(
                        labelText: '이름',
                        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400,fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                    SizedBox(height: 16,),
                    TextField(
                      controller: Logup_IDController,
                      decoration: InputDecoration(
                        labelText: '아이디',
                        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400,fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                    SizedBox(height: 16,),
                    TextField(
                      controller: Logup_passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400,fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      padding: EdgeInsets.all(0),
                      height: 50,
                      child: TextButton(
                        onPressed: (){
                          _save();
                        },
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(6),
                        // ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xffff5f6d),
                                Color(0xffff5f6d),
                                Color(0xffffc371),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(maxWidth: double.infinity,minHeight: 50),
                            child: Text('회원가입',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("멤버 ",style: TextStyle(fontWeight: FontWeight.bold),),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text("로그인",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}