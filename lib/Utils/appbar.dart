import 'package:coc_bases/Routes/routes_names.dart';
import 'package:coc_bases/Utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 10,
      title: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.homeScreen);
        },
        child: Image(
          height: mq.height * 0.1,
          width: mq.width * 0.6,
          image: const AssetImage("assets/appbar.png"),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Builder(
            builder: (context) => Container(
              width: mq.width * 0.15,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                color: AppColors.green,
              ),
              child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
                color: Colors.white,
                iconSize: 30,
              ),
            ),
          ),
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.green,
          height: 2.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
