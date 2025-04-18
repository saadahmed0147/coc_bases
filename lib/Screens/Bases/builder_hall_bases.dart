import 'package:coc_bases/Model/builderhall_model.dart';
import 'package:coc_bases/Provider/provider.dart';
import 'package:coc_bases/Routes/routes_names.dart';
import 'package:coc_bases/Utils/app_colors.dart';
import 'package:coc_bases/Utils/appbar.dart';
import 'package:coc_bases/Utils/base_drawer.dart';
import 'package:coc_bases/Utils/footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuilderhallBasesScreen extends StatefulWidget {
  const BuilderhallBasesScreen({super.key});

  @override
  State<BuilderhallBasesScreen> createState() => _BuilderhallBasesScreenState();
}

class _BuilderhallBasesScreenState extends State<BuilderhallBasesScreen> {
  @override
  Widget build(BuildContext context) {
    final builderhalls = Provider.of<BuilderhallProvider>(context).builderhalls;
    final List<BuilderModel> builderModels =
        builderhalls.map((e) => BuilderModel.fromJson(e)).toList();

    return Scaffold(
      drawer: BaseDrawer(),
      appBar: CustomAppbar(),
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  height: 40,
                  width: double.infinity,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Builder Hall Bases",
                        style: TextStyle(
                          fontSize: 20,
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

          // Grid of builder halls inside an Expanded widget
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, bottom: 10, right: 10, top: 0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: builderModels.length,
                  itemBuilder: (context, index) {
                    final builderModel = builderModels[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.builderhallLayoutScreen,
                          arguments: builderModel,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1, color: AppColors.green),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 8,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.asset(
                                  builderModel.image,
                                  width: double.infinity,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  builderModel.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Footer at the bottom
          Footer(),
        ],
      ),
    );
  }
}
