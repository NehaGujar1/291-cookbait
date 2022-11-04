import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'backEndDisplayRecipes.dart';

Future<void> display() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChoicesScreen());
}

class ChoicesScreen extends StatefulWidget {
  const ChoicesScreen({Key? key}) : super(key: key);

  @override
  State<ChoicesScreen> createState() => _ChoicesScreenState();
}

class _ChoicesScreenState extends State<ChoicesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirestoreDB().getData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<List<String>>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<List<String>>? list = snapshot.data;
          return GridView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 6.0, mainAxisSpacing: 6.0),
            itemBuilder: (context, index) {
              // resizeToAvoidBottomInset:
              // true;
              if (list[index][0] == "fetch_90") {
                return const Text(">=90%");
              } else if (list[index][0] == "fetch_80") {
                return const Text(">=80%");
              } else if (list[index][0] == "fetch_70") {
                return const Text(">=70%");
              } else if (list[index][0] == "fetch_60") {
                return const Text(">=60%");
              } else {
                return ElevatedButton(
                  // ignore: empty_statements
                    onPressed: () {
                      String? recipeID = list[index][2];

                    },
                    child: Column(
                      children: [
                        Image.network(list[index][0]),
                        Expanded(
                          child: Text(list[index][1]),
                        ),
                      ],
                    ));
              }
            },
          );
        },
      ),
    );
  }
}
