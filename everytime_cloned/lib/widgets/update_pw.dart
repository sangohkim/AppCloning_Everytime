import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

class UpdatePw extends StatefulWidget {
  const UpdatePw({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _UpdatePwState();
}

class _UpdatePwState extends State<UpdatePw> {
  TextEditingController pwController = TextEditingController();
  TextEditingController pwcController = TextEditingController();
  TextEditingController curpwController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '비밀번호 변경',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close_outlined, color: Colors.black),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 5),
                //width: MediaQuery.of(context).size.width - 20,
                child: const Text(
                  '새 비밀번호',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 45,
                child: TextFormField(
                  key: ValueKey(8),
                  obscureText: true,
                  controller: pwController,
                  decoration: InputDecoration(
                    hintText: '새 비밀번호',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
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
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 45,
                child: TextFormField(
                  key: ValueKey(8),
                  obscureText: true,
                  controller: pwcController,
                  decoration: InputDecoration(
                    hintText: '새 비밀번호 확인',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
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
                margin:
                    EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 5),
                //width: MediaQuery.of(context).size.width - 20,
                child: const Text(
                  '현재 비밀번호',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                height: 45,
                child: TextFormField(
                  key: ValueKey(8),
                  obscureText: true,
                  controller: curpwController,
                  decoration: InputDecoration(
                    hintText: '현재 비밀번호',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
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
                margin: EdgeInsets.only(left: 10, right: 10, top: 30),
                width: MediaQuery.of(context).size.width - 20,
                height: 45,
                child: ElevatedButton(
                  child: isLoading
                      ? CircularProgressIndicator.adaptive()
                      : Text('비밀번호 변경',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                  onPressed: () {
                    isLoading ? null : _updatePw();
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
    );
  }

  // 나중에 수정하기
  Future<void> _updatePw() async {
    if (_formKey.currentState?.validate() ?? false) {
      setIsLoading();
      try {
        var user = _auth.currentUser!;
        final cred = await EmailAuthProvider.credential(
            email: "${user.email}", password: "${curpwController.text}");
        await user.reauthenticateWithCredential(cred).then((value) async {
          await user.updatePassword("${pwController.text}").catchError((error) {
            ScaffoldSnackBar.of(context).show("${error.message}");
          });
        }).catchError((error) {
          ScaffoldSnackBar.of(context).show("${error.message}");
        });
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
