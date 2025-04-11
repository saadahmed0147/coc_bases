import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/provider.dart';

class BaseDrawer extends StatelessWidget {
  const BaseDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final townhalls = Provider.of<TownhallProvider>(context).townhalls;
    final builderhalls = Provider.of<BuilderhallProvider>(context).builderhalls;

    return Drawer(
      child: Container(
        color: const Color(0xFFd0f3ef),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Base Layouts',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Divider(thickness: 2, color: Colors.teal),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 3,
                      children: townhalls.map((th) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            // Add filter logic if needed
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.teal, width: 1),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  th['image'],
                                  width: 50,
                                  height: 40,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  th['baseNumber'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 3,
                      children: builderhalls.map((bh) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            // Add filter logic if needed
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.teal, width: 1),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  bh['image'],
                                  width: 50,
                                  height: 40,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  bh['baseNumber'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
    );
  }
}
