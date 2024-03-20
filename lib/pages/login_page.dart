import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tokat/pages/home_page.dart';
import 'package:tokat/pages/register_page.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final textEditingControllerEmail =TextEditingController();
  final textEditingControllerPassword =TextEditingController();
  Future<void> login() async {
    String email = textEditingControllerEmail.text;
    String password = textEditingControllerPassword.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      // Giriş butonunu devre dışı bırak
      // İşlem beklemesi gösterimi ekle

      try {
        UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        textEditingControllerEmail.clear();
        textEditingControllerPassword.clear();
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  MyHomePage(),));
      } catch (e) {
        print("Hata: $e");
      } finally {

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                child: Image.asset("assets/pic/logo_agac.png"),
          ),     Container(
                  child: Image.asset("assets/pic/logo.png"),
                ),
              ],
            ),
                SizedBox(height: 60,),
                Text(
                  "Hesabına Giriş Yap",
                  style: TextStyle(fontSize: 36.0,color: Colors.green),
                ),
                SizedBox(height: 24,),
                TextField(
                  controller: textEditingControllerEmail,
                  decoration: InputDecoration(
                    labelText: 'E-posta',
                    hintText: 'tokat@alanadi.com',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                TextField(obscureText: true,
                  controller: textEditingControllerPassword,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    hintText: '*********',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(95,187,159,100)),
                        ),
                        onPressed: login,
                        child: Text("Giriş Yap"),),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Üye değil misiniz?"),
                    TextButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyRegisterPage()),
                      );
                    }, child: Text("Kaydol!")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
