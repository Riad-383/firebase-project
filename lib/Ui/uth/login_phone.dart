import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/Ui/uth/verify_code.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({super.key});

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Phone login',
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneNumberController,
              decoration: const InputDecoration(
                  hintText: "+088 Enter your phone number"),
            ),
            const SizedBox(
              height: 60,
            ),
            RoundButton(
                loading: loading,
                title: 'login',
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted: (_) {
                        setState(() {
                    loading = false;
                  });
                      },
                      verificationFailed: (error) {
                        setState(() {
                    loading = false;
                  });
                        Utils().toastMassage(error.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VerifyCode(verificationId: verificationId),
                            ));
                            setState(() {
                    loading = false;
                  });
                      },
                      codeAutoRetrievalTimeout: (error) {
                        Utils().toastMassage(error.toString());
                        setState(() {
                    loading = false;
                  });
                      });
                })
          ],
        ),
      ),
    );
  }
}
