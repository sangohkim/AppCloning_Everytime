import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everytime_cloned/widgets/update_pw.dart';
import 'package:everytime_cloned/widgets/update_email.dart';
import 'package:everytime_cloned/widgets/update_id.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late User user;
  late TextEditingController controller;

  bool isLoading = false;

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '내 정보',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width - 20,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Image(
                    image: AssetImage('assets/logo.png'),
                    width: 50,
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 230,
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.displayName}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${user.email}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'KAIST',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      //color: Color.fromARGB(255, 185, 184, 184),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.qr_code_sharp,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width - 20,
              height: 170,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: Text(
                      '계정',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      '학교 인증',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UpdatePw();
                              },
                            ),
                          );
                        });
                      },
                      child: Text(
                        '비밀번호 변경',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UpdateEmail();
                              },
                            ),
                          );
                        });
                      },
                      child: Text(
                        '이메일 변경',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width - 20,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10),
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: Text(
                      '커뮤니티',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return UpdateId();
                        }));
                      });
                    },
                    child: Text(
                      '닉네임 설정',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '프로필 이미지 변경',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '이용 제한 내역',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '쪽지 설정',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '커뮤니티 이용규칙',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width - 20,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10),
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: Text(
                      '앱 설정',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      '다크 모드',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '알림 설정',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '암호/지문 잠금',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width - 20,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: Text(
                      '이용 안내',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      '앱 버전',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '문의하기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '공지사항',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '서비스 이용약관',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '개인정보 처리방침',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '오픈소스 라이선스',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              width: MediaQuery.of(context).size.width - 20,
              height: 170,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10),
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: Text(
                      '기타',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      '정보 동의 설정',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.currentUser!.delete();
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc('${user.displayName}_ID')
                            .delete();
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        '회원 탈퇴',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        '로그 아웃',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
