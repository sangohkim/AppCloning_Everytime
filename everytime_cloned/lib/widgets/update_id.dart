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

class UpdateId extends StatefulWidget {
  const UpdateId({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _UpdateIdState();
}

class _UpdateIdState extends State<UpdateId> {
  TextEditingController idController = TextEditingController();
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
          '닉네임 설정',
          style: TextStyle(
            color: Colors.black,
          ),
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
      body: Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 20, bottom: 10),
                width: MediaQuery.of(context).size.width - 20,
                child: Text(
                  '닉네임',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 45,
                child: TextFormField(
                  key: ValueKey(11),
                  controller: idController,
                  decoration: InputDecoration(
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
                      : Text('닉네임 설정',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                  onPressed: () {
                    isLoading ? null : _updateId();
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

  Future<void> _updateId() async {
    if (_formKey.currentState?.validate() ?? false) {
      setIsLoading();
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      var user = _auth.currentUser!;
      await users
          .doc("${user.displayName}_ID")
          .update({'userNick': idController.text}).catchError((error) {
        ScaffoldSnackBar.of(context).show(error);
      });
      // await user.updateDisplayName(idController.text).catchError((error) {
      //   ScaffoldSnackBar.of(context).show(error);
      // });
      setIsLoading();
      setState(() {
        Navigator.pop(context);
      });
    }
  }
}
