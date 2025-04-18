import 'package:coc_bases/Provider/provider.dart';
import 'package:coc_bases/Routes/routes_names.dart';
import 'package:coc_bases/Utils/app_colors.dart';
import 'package:coc_bases/Utils/appbar.dart';
import 'package:coc_bases/Utils/base_drawer.dart';
import 'package:coc_bases/Model/townhall_model.dart';
import 'package:coc_bases/Utils/footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TownhallBasesScreen extends StatefulWidget {
  const TownhallBasesScreen({super.key});

  @override
  State<TownhallBasesScreen> createState() => _TownhallBasesScreenState();
}

class _TownhallBasesScreenState extends State<TownhallBasesScreen> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    // Get the list of townhalls (raw map) from provider
    final townhallRaw = Provider.of<TownhallProvider>(context).townhalls;

    // Convert maps into model objects
    final List<TownhallModel> townhalls =
        townhallRaw.map((e) => TownhallModel.fromMap(e)).toList();

    return Scaffold(
      drawer: BaseDrawer(),
      appBar: CustomAppbar(),
      body: Column(
        children: [
          // Header section
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  height: mq.height * 0.05,
                  width: double.infinity,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Town Hall Bases",
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

          // Townhalls list (wrapped in Expanded)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: townhalls.length,
              itemBuilder: (context, index) {
                final townhall = townhalls[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.townhallLayoutScreen,
                      arguments: townhall,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: AppColors.green),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: mq.width * 0.3,
                          height: mq.height * 0.14,
                          child: Image.asset(
                            townhall.image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        SizedBox(width: mq.width * 0.02),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(11)),
                              image: const DecorationImage(
                                image: AssetImage('assets/townhall-card.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  child: Text(
                                    townhall.title,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        baseButton('War/CWL Bases'),
                                        baseButton('Farming Bases'),
                                        baseButton('Hybrid Bases'),
                                        baseButton('Funny Bases'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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

          // Footer section (optional to place inside ListView if scrollable)
          Footer(),
        ],
      ),
    );
  }

  Widget baseButton(String text) {
    Size mq = MediaQuery.of(context).size;
    return SizedBox(
      height: mq.height * 0.03,
      width: mq.width * 0.25,
      child: ElevatedButton(
        onPressed: () {
          // Navigation or filter logic can be added here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
