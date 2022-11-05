import 'package:cookbait/frontEndIndividualRecipe.dart';
import 'package:flutter/material.dart';
import 'backEndCommentSection.dart';

Widget _buildHeading({String name = ' '}) {
  return Container(
    width: 300,
    //height: 40,
    clipBehavior: Clip.none,
    child: Text(
      name,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _buildNormalText({String name = ' '}) {
  return Text(
    name,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black38,
    ),
  );
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Enter New Comment'),
        title: _buildHeading(name: 'Enter New Comment'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
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
                child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        name = nameController.text;
                        comment = commentController.text;
                        email = emailController.text;
                        await FireBaseCollectionOfComments().addData(
                            name, email, comment, widget.recipeID, context);
                        if (!mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IndividualRecipe(
                                    recipeID: widget.recipeID)));
                      }
                    },
                    //child: const Text("Submit Data")),
                    child: _buildNormalText(name: 'Comment')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
