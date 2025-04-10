import 'package:coc_bases/Data/builderhall_data';
import 'package:coc_bases/Utils/app_colors.dart';
import 'package:flutter/material.dart';

class BuilderhallBasesScreen extends StatefulWidget {
  const BuilderhallBasesScreen({super.key});

  @override
  State<BuilderhallBasesScreen> createState() => _BuilderhallBasesScreenState();
}

class _BuilderhallBasesScreenState extends State<BuilderhallBasesScreen> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 10,
        title: Image(
          height: mq.height * 1,
          width: mq.width * 0.6,
          image: AssetImage("assets/appbar.png"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: mq.width * 0.15,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                color: AppColors.green,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu),
                color: Colors.white,
                iconSize: 30,
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: AppColors.green,
            height: 2.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  color: AppColors.green,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
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
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
                itemCount: builderHalls.length,
                itemBuilder: (context, index) {
                  final th = builderHalls[index];
                  return Container(
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
                              th['image'],
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
                              th['title'],
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
                  );
                }),
          ),
        ],
      ),
    );
  }
}
