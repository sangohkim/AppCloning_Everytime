import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ScaffoldSnackBar {
  // helper class
  ScaffoldSnackBar(this._context);

  factory ScaffoldSnackBar.of(BuildContext context) {
    return ScaffoldSnackBar(context);
  }

  final BuildContext _context;

  void show(String message) {
    ScaffoldMessenger.of(_context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key); // 이 구문의 의미는 무엇일까??
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String error = '';
  bool isLoading = false;

  void setIsLoading() {
    isLoading = !isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                const Image(
                  image: AssetImage('assets/logo.png'),
                  width: 90,
                  height: 90,
                ),
                const Text(
                  "대학 생활을 더 편하고 즐겁게",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const Text(
                  "에브리타임",
                  style: TextStyle(
                      color: Color.fromARGB(255, 199, 50, 39),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                            key: const ValueKey(1),
                            controller: idController,
                            decoration: const InputDecoration(
                              hintText: '아이디',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text!!';
                              }
                              return null;
                            }),
                        const SizedBox(height: 10),
                        TextFormField(
                            key: const ValueKey(2),
                            controller: pwController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: '비밀번호',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text!!';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 60,
                          height: 50,
                          child: ElevatedButton(
                            child: isLoading
                                ? const CircularProgressIndicator.adaptive()
                                : Text(
                                    '에브리타임 로그인',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                            onPressed: () {
                              isLoading ? null : _idAndPw();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 199, 50, 39),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: GestureDetector(
                              child: Text(
                                "아이디/비밀번호 찾기",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onTap: () {
                                // 아이디 비번 찾는 페이지로 연결
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: GestureDetector(
                            onTap: () {
                              isLoading ? null : null;
                            },
                            child: const Text(
                              "회원가입",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _idAndPw() async {
    if (_formKey.currentState?.validate() ?? false) {
      // validate 할때만 if문 내부가 실행됨
      setIsLoading();
      String userEmail = '';
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      var check = await users.doc("${idController.text}_ID").get();
      if (check.exists) {
        await users.doc("${idController.text}_ID").get().then((value) {
          userEmail = value['userEmail'];
        });
        try {
          await _auth.signInWithEmailAndPassword(
            email: userEmail,
            password: pwController.text,
          );
        } on FirebaseAuthMultiFactorException catch (e) {
          setState(() {
            error = '${e.message}';
            print(error);
          });
        }
      } else {
        ScaffoldSnackBar.of(context)
            .show('Error occured when getting data from database!');
      }
      setIsLoading();
    }
  }
}
