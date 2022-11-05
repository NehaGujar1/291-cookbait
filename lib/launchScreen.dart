import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class launchScreen extends StatefulWidget {
  const launchScreen({super.key});

  @override
  State<launchScreen> createState() => _launchScreenState();
}

// ignore: camel_case_types
class _launchScreenState extends State<launchScreen> {
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 800),
      child: Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          body: Center(
              child: SingleChildScrollView(
            //child: Card(
            child: Container(
              color: const Color(0xFFF9F9F9),
              padding: const EdgeInsets.all(25),
              child: Column(children: <Widget>[
                const Text(
                  "Welcome!",
                  style: TextStyle(
                      fontFamily: 'raleway',
                      fontSize: 32,
                      color: Color(0xFFD80041),
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.start,
                ),
                const Text(
                  "Save your time and efforts with Cookbait...",
                  style: TextStyle(
                      fontFamily: 'nunito',
                      fontSize: 18,
                      color: Color.fromARGB(255, 68, 62, 62)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 440,
                  child: GridView.count(
                    shrinkWrap: true,
                    childAspectRatio: 1.25,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    children: [
                      Image.asset(
                        'assets/ingredients.png',
                      ),
                      const Center(
                        child: Text(
                          "Select the ingredients available to you...",
                          style: TextStyle(
                              fontFamily: 'nunito',
                              fontSize: 14,
                              color: Color.fromARGB(255, 68, 62, 62)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Image.asset('assets/search.png'),
                      const Center(
                        child: Text(
                          "Search through a database of over 6000 recipes to find the most suitable recipe",
                          style: TextStyle(
                              fontFamily: 'nunito',
                              fontSize: 14,
                              color: Color.fromARGB(255, 68, 62, 62)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Image.asset(
                        'assets/cook.png',
                      ),
                      const Center(
                        child: Text(
                          "Follow the step by step recipe and enjoy!",
                          style: TextStyle(
                              fontFamily: 'nunito',
                              fontSize: 14,
                              color: Color.fromARGB(255, 68, 62, 62)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.topLeft,
                        backgroundColor: const Color(0xFFD80041),
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(32)),
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                      child: const Center(
                          child: Text(
                        "Get Started!",
                        style: TextStyle(
                            fontFamily: 'nunito',
                            fontSize: 18,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ))),
                ),
              ]),
            ),
          ))),
    );
  }
}
