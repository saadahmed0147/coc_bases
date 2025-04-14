import 'package:coc_bases/Model/builderhall_model.dart';
import 'package:coc_bases/Utils/app_colors.dart';
import 'package:coc_bases/Utils/appbar.dart';
import 'package:coc_bases/Utils/base_drawer.dart';
import 'package:coc_bases/Utils/footer.dart';
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
      body: ListView(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                  height: 40,
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "${hall.title} Layouts",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  height: 2,
                  width: double.infinity,
                  color: AppColors.green,
                ),
              ],
            ),
          ),

          // Layout list
          ...hall.layouts.map((layout) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Stack(
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
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: CircularProgressIndicator(
                                    color: AppColors.green,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Share.share(layout.link,
                            subject: 'Check out this COC Layout!');
                      },
                      icon: const Icon(
                        Icons.share,
                        size: 15,
                        color: Colors.deepOrange,
                      ),
                      label: const Text(
                        'Share Layout',
                        style: TextStyle(fontSize: 10),
                      ),
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
              ),
            );
          }).toList(),

          // Footer
          Footer(),
        ],
      ),
    );
  }
}
