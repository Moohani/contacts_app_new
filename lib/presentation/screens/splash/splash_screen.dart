import 'dart:async';
import 'package:contacts_app_new/constans/screens.dart' as screens;

import 'package:contacts_app_new/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
    late final AnimationController _controller;
    late final Animation<double> _animation;

    @override
   void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
    );
    Timer(const Duration(milliseconds: 4000),
            () {
      Navigator.of(context).pushNamedAndRemoveUntil(screens.homeLayout, (route) => false);
            });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Stack(
        children: [
          TweenAnimationBuilder(
              duration: const Duration(milliseconds: 3000),
              tween: Tween<double>(
                begin: 0,
                end: 100.h
              ),
            builder: (BuildContext context, double? value, Widget? child) =>
                Container(
                  height: value,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                  colors:[
                    skyBlue,
                    lightPurple,
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: FadeTransition(
                    opacity: _animation,
                    child: Image(
                      height: 30.h,
                      width: 70.w,
                      image: const AssetImage('assets/icons8-contacts-100.png'),
                    ),
                  ),
                ),
                const Flexible(
                  child: Text('MY CONTACTS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: lightSkyBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
