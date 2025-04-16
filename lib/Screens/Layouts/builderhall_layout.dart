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
  String? selectedFilter;

  List<String> getAllCategories() {
    final Set<String> categories = {};
    for (var layout in widget.hall.layouts) {
      categories.addAll(layout.categories);
    }
    return categories.toList();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final filteredLayouts = selectedFilter == null
        ? widget.hall.layouts
        : widget.hall.layouts
            .where((layout) => layout.categories.contains(selectedFilter))
            .toList();

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
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Row(
                      children: [
                        Text(
                          widget.hall.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.green,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    // Filter Dropdown
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        setState(() {
                          selectedFilter =
                              value == '[No Filter]' ? null : value;
                        });
                      },
                      itemBuilder: (context) {
                        final allItems = ['[No Filter]', ...getAllCategories()];
                        return allItems
                            .map((item) => PopupMenuItem(
                                  value: item,
                                  child: Text(item),
                                ))
                            .toList();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              selectedFilter ?? '[No Filter]',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.green,
                            ),
                          ],
                        ),
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
                  // Layout list
                  ...filteredLayouts.map((layout) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
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
                                height: mq.height * 0.35,
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
                                  Wrap(
                                    children: layout.categories.map((category) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Chip(
                                          label: Text(
                                            "#$category",
                                            style: TextStyle(
                                              color: AppColors.green,
                                              fontSize: 10,
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
                                      );
                                    }).toList(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                text: layout.link));
                                            launchUrl(
                                              Uri.parse(layout.link),
                                              mode: LaunchMode.platformDefault,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.download_sharp,
                                            size: 17,
                                            color: Colors.grey,
                                          ),
                                          label: const Text(
                                            'Copy Base',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            foregroundColor: Colors.black,
                                            shape: const LinearBorder(),
                                          ),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            Share.share(layout.link,
                                                subject:
                                                    'Check out this COC Layout!');
                                          },
                                          icon: Icon(
                                            Icons.share,
                                            size: 15,
                                            color: AppColors.green,
                                          ),
                                          label: const Text(
                                            'Share Layout',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            foregroundColor: Colors.black,
                                            shape: const LinearBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
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
