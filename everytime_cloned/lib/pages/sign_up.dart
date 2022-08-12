import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ScaffoldSnackBar {
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

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwcController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void setIsLoading() {
    isLoading = !isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: Text(
            '뒤로',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text('회원가입', style: TextStyle(color: Colors.black)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close_outlined, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // AppBar에 생기는 back arrow 없애주는 기능
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 20,
                  child: Text(
                    '학교 입력',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
                  child: TextFormField(
                    key: const ValueKey(3),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      suffixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(
                          Icons.search_outlined,
                        ),
                      ),
                      suffixIconColor: Colors.grey,
                    ),
                    onChanged: (value) {},
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  child: const Text(
                    '로그인 정보 입력',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
                // ListView를 column 안에서 쓰면 무조건 Container나 SizedBox 안에 넣어서 높이 지정 후에 사용해야 함
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 240,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ListView(
                    padding: EdgeInsets.all(3.0),
                    children: <Widget>[
                      Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: TextFormField(
                          key: ValueKey(4),
                          controller: idController,
                          decoration: const InputDecoration(
                            hintText: '아이디',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text!!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: TextFormField(
                          key: ValueKey(5),
                          controller: pwController,
                          decoration: const InputDecoration(
                            hintText: '비밀번호',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text!!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: TextFormField(
                          key: ValueKey(6),
                          controller: pwcController,
                          decoration: const InputDecoration(
                            hintText: '비밀번호확인',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text!!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: TextFormField(
                          key: ValueKey(7),
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: '이메일',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text!!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  height: 50,
                  child: ElevatedButton(
                    child: isLoading
                        ? CircularProgressIndicator.adaptive()
                        : Text('회원가입',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                    onPressed: () {
                      isLoading ? null : _emailAndPw();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 199, 50, 39),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
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

  Future<void> _emailAndPw() async {
    if (_formKey.currentState?.validate() ?? false) {
      setIsLoading();
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc('${idController.text}_ID').set({
        'userEmail': emailController.text,
        'userName': idController.text,
      }).catchError((error) {
        ScaffoldSnackBar.of(context).show(error);
      });
      try {
        await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: pwController.text,
        );
        setIsLoading();
        setState(() {
          Navigator.pop(context);
        });
      } on FirebaseAuthMultiFactorException catch (e) {
        setState(() {
          ScaffoldSnackBar.of(context).show('${e.message}');
        });
        setIsLoading();
      }
    }
  }
}
