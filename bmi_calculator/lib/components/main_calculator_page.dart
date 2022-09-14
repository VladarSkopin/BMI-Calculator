import 'package:bmi_calculator/components/bmi_calculation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';


class MainCalculatorPage extends StatefulWidget {
  const MainCalculatorPage({Key? key}) : super(key: key);

  @override
  State<MainCalculatorPage> createState() => _MainCalculatorPageState();
}

class _MainCalculatorPageState extends State<MainCalculatorPage> {

  int _weight = 0;
  int _height = 0;
  double _bmiResult = 0.0;
  String _bmiOutput = "";
  String _verdict = "";

  late final FocusNode _heightFocusNode;

  late AudioPlayer _player;
  String _btnSnd = 'assets/btn_snd.mp3';
  bool _isError = false;

  @override
  void initState() {
    _player = AudioPlayer();
    _heightFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    _heightFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 3;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('BMI Awesome Calculator')),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey[100]!,
                Colors.grey[400]!
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Using this BMI calculator is super easy! Just enter your weight (kg) and height (cm), tap the Enter button, confirm and see the result below!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: TextFormField(
                  onChanged: (text) {
                    setState(() {
                      _isError = false;
                      try {
                        _weight = double.parse(text).round();
                      } catch (ex) {
                        _isError = true;
                      }

                    });
                  },
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.purple,
                  cursorWidth: 1.8,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                  decoration: InputDecoration(
                    hintText: 'Weight (kg)',
                    hintStyle: TextStyle(
                      color: Colors.grey[500]
                    ),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),

                    )
                  ),
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_heightFocusNode);
                  }
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: TextFormField(
                  focusNode: _heightFocusNode,
                  onChanged: (text) {
                    setState(() {
                      _isError = false;
                      try {
                        _height = double.parse(text).round();
                      } catch (ex) {
                        _isError = true;
                      }
                    });
                  },
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.purple,
                  cursorWidth: 1.8,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),
                  decoration: InputDecoration(
                      hintText: 'Height (cm)',
                      hintStyle: TextStyle(
                          color: Colors.grey[500]
                      ),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      )
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth),
                child: MaterialButton(
                  onPressed: () async {
                    /*
                    Navigator.pushReplacement(context, PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 600),
                      child: SecondCalculatorPage(),
                    ));
                     */

                    setState(() {
                      _bmiResult = BmiCalculation.calculateBmiIndex(_weight, _height);
                      _bmiResult = double.parse((_bmiResult).toStringAsFixed(2));
                      _verdict = BmiCalculation.calculateBmiVerdict(_bmiResult);
                      _bmiOutput = 'BMI: $_bmiResult';
                      if (_weight <= 0 || _height <= 0) {
                        _isError = true;
                        _bmiOutput = "Unknown BMI Index";
                        _verdict = "Unknown result";
                      } else {
                        _isError = false;
                      }
                      if (_isError) {
                        _btnSnd = "assets/btn_error.mp3";
                      } else {
                        _btnSnd = "assets/btn_snd.mp3";
                      }
                    });

                    if (_player.playing) {
                      _player.stop();
                    }
                    await _player.setAsset(_btnSnd);
                    _player.play();

                  },
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)
                  ),
                  elevation: 6.0,
                  child: const Text(
                    'ENTER',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text('$_bmiOutput'
                  '\n$_verdict',
                  style: TextStyle(
                      color: Colors.red[600],
                      fontSize: 26,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
              overflow: TextOverflow.fade),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
