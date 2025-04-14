import 'package:coc_bases/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Container(
      height: mq.height * 0.04,
      color: AppColors.green,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Visit Our Official Website: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      )),
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                          Uri.parse(
                            "https://bases-coc.com/",
                          ),
                          mode: LaunchMode.platformDefault);
                    },
                    child: Text(
                      "https://bases-coc.com/ ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10,
                        decoration: TextDecoration
                            .underline, // Optional: underline the text
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
