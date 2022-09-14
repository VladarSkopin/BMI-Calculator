import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MainCalculatorPage extends StatefulWidget {
  const MainCalculatorPage({Key? key}) : super(key: key);

  @override
  State<MainCalculatorPage> createState() => _MainCalculatorPageState();
}

class _MainCalculatorPageState extends State<MainCalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('BMI Awesome Calculator')),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                //Colors.orange[200]!,
                //Colors.amber[200]!,
                Colors.grey[100]!,
                Colors.grey[400]!
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Using this BMI calclulator is super easy! Just Enter your weight and height, tap the Enter button, confirm and see the results below!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              TextField(),
              TextField(),
              MaterialButton(
                onPressed: () {
                  /*
                  Navigator.pushReplacement(context, PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 600),
                    child: SecondCalculatorPage(),
                  ));
                   */
                },
                color: Colors.black,
                child: const Text(
                  'ENTER',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
                ),
                elevation: 6.0,
              ),
              Text('abcABC\nabc',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 26,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
