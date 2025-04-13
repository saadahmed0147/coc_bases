import 'package:coc_bases/Routes/routes_names.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: mq.width * 1,
            height: mq.height * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/splash.jpg"), fit: BoxFit.fill)),
          )
        ],
      ),
    );
  }
}
