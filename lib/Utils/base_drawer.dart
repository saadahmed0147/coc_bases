import 'package:coc_bases/Model/builderhall_model.dart';
import 'package:coc_bases/Model/townhall_model.dart';
import 'package:coc_bases/Routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/provider.dart';

class BaseDrawer extends StatelessWidget {
  const BaseDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Get data from the provider
    final townhalls = Provider.of<TownhallProvider>(context).townhalls;
    final builderhalls = Provider.of<BuilderhallProvider>(context).builderhalls;

    // Map the townhalls and builderhalls data to models
    final List<TownhallModel> townhallModels = townhalls
        .map<TownhallModel>((item) => TownhallModel.fromMap(item))
        .toList();
    final List<BuilderModel> builderhallModels = builderhalls
        .map<BuilderModel>((item) => BuilderModel.fromJson(item))
        .toList();

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFd0f3ef), Color(0xFFb2e4dd)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Base Layouts',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  letterSpacing: 1.2,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  thickness: 2,
                  color: Colors.teal,
                  indent: 30,
                  endIndent: 30,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Town Halls',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Grid for Townhalls
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 3.8,
                        children: townhallModels.map((item) {
                          return Material(
                            elevation: 2,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.townhallLayoutScreen,
                                  arguments:
                                      item, // Pass the entire builderhall item as argument
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      item.image, // Access image from the TownhallModel
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.contain,
                                    ),
                                    Expanded(
                                      child: Text(
                                        item.baseNumber, // Access baseNumber from the TownhallModel
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.teal,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Builder Halls',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Grid for Builderhalls
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 3.8,
                        children: builderhallModels.map((item) {
                          return Material(
                            elevation: 2,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.builderhallLayoutScreen,
                                  arguments:
                                      item, // Pass the entire builderhall item as argument
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      item.image, // Access image from the BuilderModel
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.contain,
                                    ),
                                    Expanded(
                                      child: Text(
                                        item.baseNumber, // Access baseNumber from the BuilderModel
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.teal,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
