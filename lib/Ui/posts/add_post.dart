import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  bool loading = false;

  final postCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postCtrl,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Whats on your mind..?',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                loading: loading,
                title: "Post",
                onTap: () {
                  setState(() {
                    loading = true;
                  });

                  String id=DateTime.now().millisecondsSinceEpoch.toString();
                  databaseRef
                      .child(id)
                      .set({'title': postCtrl.text.toString(), 
                      'id': id,
                      }).then(
                          (value) {
                             
                    Utils().toastMassage('Post added');

                    setState(() {
                    loading = false;
                  });
                  
                  }).onError((error, stackTrace) {

                    
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
