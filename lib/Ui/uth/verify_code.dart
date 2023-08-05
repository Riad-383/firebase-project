import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/Ui/posts/post_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';

class VerifyCode extends StatefulWidget {
  String verificationId;
  VerifyCode({super.key, required this.verificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final verifyCodeCtrl = TextEditingController();
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
              controller: verifyCodeCtrl,
              decoration: const InputDecoration(hintText: "6 Digit code"),
            ),
            const SizedBox(
              height: 60,
            ),
            RoundButton(
                loading: loading,
                title: 'Verify',
                onTap: () async {
                  setState(() {
                    loading = true;
                  });

                  final token = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verifyCodeCtrl.toString());

                  try {
                    await auth.signInWithCredential(token);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PostScreen(),
                        ));
                  } catch (error) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMassage(error.toString());
                  }
                })
          ],
        ),
      ),
    );
  }
}
