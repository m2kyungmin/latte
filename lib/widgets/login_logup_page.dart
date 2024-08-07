import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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

class LoginPage extends StatelessWidget{
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
                        Text('Welcome',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                        SizedBox(height: 6,),
                        Text('Sign in to continue!',style: TextStyle(fontSize: 20,color: Colors.grey.shade400),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Email ID',
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
                          decoration: InputDecoration(
                              labelText: 'Password',
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
                          child: Text('Forgot Password',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                        ),

                        SizedBox(height: 30,),

                        Container(
                          height: 50,
                          width: double.infinity,
                          child: TextButton(
                            onPressed: (){},
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
                                child: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),

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
                          Text("I'am a new user.",style: TextStyle(fontWeight: FontWeight.bold),),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                            },
                            child: Text("Sign up.",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
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

class SignupPage extends StatelessWidget{
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
                    Text("Create Account",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                    SizedBox(height: 6,),
                    Text('Sign up to get started!',style: TextStyle(fontSize: 20,color: Colors.grey.shade400),),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
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
                      decoration: InputDecoration(
                        labelText: 'Email ID',
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
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                        onPressed: (){},
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
                            child: Text('Sign up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
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
                      Text("I'am already a member.",style: TextStyle(fontWeight: FontWeight.bold),),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text("Sign in",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
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