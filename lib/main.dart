import 'package:animated_background/animated_background.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:html' as html;

import 'package:valentine/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyAnimatedBackground());
}

class MyAnimatedBackground extends StatefulWidget {
  MyAnimatedBackground({Key? key}) : super(key: key);

  @override
  State<MyAnimatedBackground> createState() => _MyAnimatedBackgroundState();
}

class _MyAnimatedBackgroundState extends State<MyAnimatedBackground>
    with SingleTickerProviderStateMixin {
  ParticleOptions particles = ParticleOptions(
    baseColor: Colors.red[100] ?? Colors.red,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    particleCount: 70,
    spawnMaxRadius: 15.0,
    spawnMaxSpeed: 100.0,
    spawnMinSpeed: 30,
    spawnMinRadius: 7.0,
  );
  double _redButtonWidth = 200;
  double _greenButtonWidth = 200;
  double _greenButtonTextSize = 16.0;
  double _redButtonTextSize = 12.0;
  bool no = true;
  bool yes = true;
  int _clickCount = 0;
  List<String> _convincingTexts = [
    "No?",
    "Are you sure?",
    "Really sure?",
    "Are you really, really sure?",
    "Are you positive?",
    "Just think about it...",
    "I promise it'll be worth it",
    "Consider giving it a chance.",
    "If you say no, I'll be sad.",
    "I will be very sad",
    "I'll be very very sad.",
    "Ok fine, I'll stop asking.",
    "Just kidding, please say yes.",
    'Think again...',
    "I will be very very very very sad.",
    'You are breaking my heart...',
  ];
  @override
  Widget build(BuildContext context) {
    // return MaterialApp
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: AnimatedBackground(
            // vsync uses singleTicketProvider state mixin.
            vsync: this,
            behaviour: RandomParticleBehaviour(options: particles),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: yes
                      ? <Widget>[
                          Lottie.asset(
                            'assets/love.json',
                            width: 200,
                            height: 200,
                          ),
                          Text('Will you be my Valentine?',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: _greenButtonWidth,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      yes = false;
                                    });
                                  },
                                  child: Text(
                                    'Yes',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _greenButtonTextSize,
                                        fontWeight: FontWeight
                                            .bold // use the text size variable here
                                        ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                width: _redButtonWidth,
                                child: Visibility(
                                  visible: no,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (_clickCount <
                                            _convincingTexts.length - 1) {
                                          _clickCount++;
                                          _redButtonWidth -= 5;
                                          _greenButtonWidth += 36;
                                          _redButtonTextSize -= 0.1;
                                          _greenButtonTextSize += 27;
                                        } else {
                                          no = false;
                                        }
                                      });
                                    },
                                    child: Text(
                                      _convincingTexts[_clickCount],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _redButtonTextSize,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                      : <Widget>[
                          Image.asset('assets/kiss.gif',
                              width: 200, height: 200),
                          Text('Ok Yay!!!!',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              setState(() {
                yes = true;
                no = true;
                _clickCount = 0;
                _redButtonWidth = 200;
                _greenButtonWidth = 200;
                _greenButtonTextSize = 16.0;
                _redButtonTextSize = 12.0;
              });
              const url = 'https://www.linkedin.com/in/alaminxpro/';
              html.window.open(url, '_blank');
            },
            child: Image.asset('assets/A.png'),
          ),
        ));
  }
}
