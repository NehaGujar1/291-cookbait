import 'package:flutter/material.dart';
import 'backEndCommentSection.dart';

class CommentSection extends StatefulWidget {
  final String recipeID;

  const CommentSection({Key? key, required this.recipeID}) : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  String? name, email, comment;

  void addDataToBackend(String? name, String? email, String? comment,
      String recipeID) async {
    await FireBaseCollectionOfComments()
        .addData(name, email, comment, recipeID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD80041),
        title: const Text(
          'Enter new Comment!!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your name',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                      ),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 5,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Enter Correct Name";
                    } else {
                      return null;
                    }
                  },
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  onSaved: (value) {
                    nameController.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your Email',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                      ),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 5,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                      return "Enter Correct Email Address";
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                ),
              ),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your Comment goes here',
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                  maxLines: null,
                  expands: true,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Size of comment should not be less than 3";
                    } else {
                      return null;
                    }
                  },
                  controller: commentController,
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    commentController.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD80041),
                      shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(32),
                      ),
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        name = nameController.text;
                        comment = commentController.text;
                        email = emailController.text;
                        Navigator.of(context).pop();
                        addDataToBackend(
                            name, email, comment, widget.recipeID);
                      }
                    },
                    child: const Text(
                      'Add comment',
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
}
