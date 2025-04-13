import 'package:coc_bases/Model/builderhall_model.dart';
import 'package:coc_bases/Provider/provider.dart';
import 'package:coc_bases/Routes/routes_names.dart';
import 'package:coc_bases/Utils/app_colors.dart';
import 'package:coc_bases/Utils/appbar.dart';
import 'package:coc_bases/Utils/base_drawer.dart';
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

    return Scaffold(
      drawer: BaseDrawer(),
      appBar: CustomAppbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  color: AppColors.green,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Builder Hall Bases",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  height: 2,
                  width: double.infinity,
                  color: AppColors.green,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
                itemCount: builderhalls.length,
                itemBuilder: (context, index) {
                  final builderModel =
                      BuilderModel.fromJson(builderhalls[index]);

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
                            flex: 4,
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
                                  fontSize: 18,
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
                }),
          ),
        ],
      ),
    );
  }
}
