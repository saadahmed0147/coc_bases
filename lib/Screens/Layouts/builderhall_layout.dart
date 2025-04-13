import 'package:coc_bases/Model/builderhall_model.dart';
import 'package:coc_bases/Utils/app_colors.dart';
import 'package:coc_bases/Utils/appbar.dart';
import 'package:coc_bases/Utils/base_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class BuilderhallLayoutScreen extends StatelessWidget {
  final BuilderModel hall;

  const BuilderhallLayoutScreen({super.key, required this.hall});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbar(),
      drawer: BaseDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 2,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Text(
              "Builderhall ${hall.baseNumber} Layouts",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: hall.layouts.length,
              itemBuilder: (context, index) {
                final layout = hall.layouts[index];
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: layout.link));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                const Text('Layout link copied to clipboard!'),
                            backgroundColor: AppColors.green,
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                      child: SizedBox(
                          width: double.infinity,
                          height: mq.height * 0.25,
                          child: Card(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                layout.image,
                                fit: BoxFit.fill,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.green,
                                    )),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          )),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Share.share(layout.link,
                              subject: 'Check out this COC Layout!');
                        },
                        icon: const Icon(
                          Icons.share,
                          color: Colors.deepOrange,
                        ),
                        label: const Text('Share Layout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
