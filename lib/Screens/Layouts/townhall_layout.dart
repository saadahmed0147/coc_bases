import 'package:coc_bases/Model/townhall_model.dart';
import 'package:coc_bases/Utils/app_colors.dart';
import 'package:coc_bases/Utils/appbar.dart';
import 'package:coc_bases/Utils/base_drawer.dart';
import 'package:coc_bases/Utils/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class TownhallLayoutScreen extends StatefulWidget {
  final TownhallModel hall;
  final String? selectedCategory;

  const TownhallLayoutScreen(
      {super.key, required this.hall, this.selectedCategory});

  @override
  State<TownhallLayoutScreen> createState() => _TownhallLayoutScreenState();
}

class _TownhallLayoutScreenState extends State<TownhallLayoutScreen> {
  String? selectedFilter;
  late String? selectedCategory;
  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
    selectedFilter = selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final Map<String, String> categoryMap = {
      'War': 'CWL/War Bases',
      'Farming': 'Farming Bases',
      'Funny': 'Funny Bases',
      'Hybrid': 'Hybrid Bases',
      'Anti 2 star': 'Anti 2 Stars Bases',
      'Anti 3 star': 'Anti 3 Stars Bases',
      'Anti air': 'Anti Air/Anti Electro Bases',
      'Anti trophy': 'Anti Trophy Bases',
    };

    final filteredLayouts = selectedFilter == null
        ? widget.hall.layouts
        : widget.hall.layouts.where((layout) {
            // Check if the layout has a category that matches the backend category
            return layout.categories.any((category) {
              // Find the backend category from the selected frontend filter
              final backendCategory = categoryMap.keys.firstWhere(
                  (key) => categoryMap[key] == selectedFilter,
                  orElse: () => '');
              return category == backendCategory;
            });
          }).toList();

    String truncateWithEllipsis(String text, {int cutoff = 12}) {
      return (text.length <= cutoff) ? text : '${text.substring(0, cutoff)}...';
    }

    return Scaffold(
      appBar: CustomAppbar(),
      drawer: BaseDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Row(
                      children: [
                        Text(
                          " ${widget.hall.title}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.green,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    // Filter Dropdown
                    SizedBox(
                      width: mq.width * 0.3,
                      child: PopupMenuButton<String>(
                        onSelected: (value) {
                          setState(() {
                            selectedFilter =
                                value == '[No Filter]' ? null : value;
                          });
                        },
                        itemBuilder: (context) {
                          // Adding '[No Filter]' to the list and the frontend categories
                          final allItems = [
                            '[No Filter]',
                            ...categoryMap.values.toList()
                          ];
                          return allItems
                              .map((item) => PopupMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontSize: 12,
                                          overflow: TextOverflow.clip),
                                    ),
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
                              Flexible(
                                child: Text(
                                  truncateWithEllipsis(
                                      selectedFilter ?? '[No Filter]'),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
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
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Layout list or empty message
          Expanded(
            child: filteredLayouts.isEmpty
                ? Center(
                    child: Text(
                      'No layouts available for this category.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ...filteredLayouts.map((layout) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: layout.link));
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
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppColors.green,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(Icons.error);
                                          },
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                      ClipboardData(
                                                          text: layout.link));
                                                  launchUrl(
                                                    Uri.parse(layout.link),
                                                    mode: LaunchMode
                                                        .platformDefault,
                                                  );
                                                },
                                                child: Chip(
                                                  label: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10),
                                                    child: Row(
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
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      AppColors.green,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 0),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal: -2,
                                                          vertical: -2),
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.share,
                                                          size: 15,
                                                          color:
                                                              AppColors.green,
                                                        ),
                                                        Text(
                                                          '  Share Layout',
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      const Color(0xFFd0f3ef),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 0),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal: -2,
                                                          vertical: -2),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Wrap(
                                            children: layout.categories
                                                .map((category) {
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
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
          ),

          Footer(),
        ],
      ),
    );
  }
}
