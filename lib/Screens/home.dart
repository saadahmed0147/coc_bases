import 'package:coc_bases/Provider/provider.dart';
import 'package:coc_bases/Routes/routes_names.dart';
import 'package:coc_bases/Utils/animated_banner.dart';
import 'package:coc_bases/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    final provider = Provider.of<AppProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        title: Center(
          child: Image(
            height: mq.height * 0.4,
            width: mq.width * 0.8,
            image: AssetImage("assets/appbar.png"),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: AppColors.green,
            height: 2.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg-image.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: mq.height * 0.06),

                  // ✅ Townhall Banner
                  AnimatedClickableBanner(
                    height: mq.height * 0.3,
                    image: "assets/townhall-banner.png",
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.townhallScreen);
                    },
                  ),

                  // ✅ Builderhall Banner
                  AnimatedClickableBanner(
                    height: mq.height * 0.3,
                    image: "assets/builderhall-banner.png",
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.builderhallScreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
