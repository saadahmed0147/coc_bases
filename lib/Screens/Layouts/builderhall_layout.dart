import 'package:coc_bases/Model/builderhall_model.dart';
import 'package:coc_bases/Utils/app_colors.dart';
import 'package:coc_bases/Utils/appbar.dart';
import 'package:coc_bases/Utils/base_drawer.dart';
import 'package:coc_bases/Utils/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class BuilderhallLayoutScreen extends StatefulWidget {
  final BuilderModel hall;

  const BuilderhallLayoutScreen({super.key, required this.hall});

  @override
  State<BuilderhallLayoutScreen> createState() =>
      _BuilderhallLayoutScreenState();
}

class _BuilderhallLayoutScreenState extends State<BuilderhallLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppbar(),
      drawer: BaseDrawer(),
      body: Column(
        children: [
          // Image Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.hall.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.green,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Expanded body with scrollable list of layouts
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...widget.hall.layouts.map((layout) {
                    return GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: layout.link));
                        launchUrl(
                          Uri.parse(layout.link),
                          mode: LaunchMode.platformDefault,
                        );
                      },
                      child: Card(
                        elevation: 0,
                        child: Column(
                          children: [
                            SizedBox(
                              height: mq.height * 0.24,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  layout.image,
                                  fit: BoxFit.fill,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: CircularProgressIndicator(
                                          color: AppColors.green,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Clipboard.setData(
                                              ClipboardData(text: layout.link));
                                          launchUrl(
                                            Uri.parse(layout.link),
                                            mode: LaunchMode.platformDefault,
                                          );
                                        },
                                        child: Chip(
                                          label: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.download_sharp,
                                                  size: 17,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  '  Copy Base',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          backgroundColor: AppColors.green,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 0),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: const VisualDensity(
                                              horizontal: -2, vertical: -2),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Share.share(layout.link,
                                              subject:
                                                  'Check out this COC Layout!');
                                        },
                                        child: Chip(
                                          label: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.share,
                                                  size: 15,
                                                  color: AppColors.green,
                                                ),
                                                Text(
                                                  '  Share Layout',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ),
                                          backgroundColor:
                                              const Color(0xFFd0f3ef),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 0),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: const VisualDensity(
                                              horizontal: -2, vertical: -2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Wrap(
                                    children: layout.categories.map((category) {
                                      return Text(
                                        "#$category  ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Footer (always stays at the bottom)
          Footer(),
        ],
      ),
    );
  }
}
