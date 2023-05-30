import 'dart:async';

import 'package:covid_19/view/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void initState()
  {
    super.initState();
    
    Timer(Duration(seconds: 3), () => Navigator.push(context,
        MaterialPageRoute(builder: (context) => WorldStatesScreen())));
  }

  @override
  build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _controller,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: const Center(
                      child: Image(image: AssetImage("images/virus.png"),),
                    ),
                  ),
                  builder: (BuildContext context, Widget? child)
                  {
                    return Transform.rotate(
                        angle: _controller.value * 2.0 * math.pi,
                      child: child,
                    );
                  }
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text("Covid-19\nTracker App", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)),

            ],
          ),
        ),
      ),
    );
  }
}
