import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:tankobon_mobile/src/views/widget/gradient_app_bar.dart';
import 'package:tankobon_mobile/src/api/models/models.dart';
import 'package:tankobon_mobile/src/api/client.dart';
import 'package:tankobon_mobile/src/views/widget/item_result.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  Icon customIcon = const Icon(LineIcons.search);
  Widget? customSearchBar;
  Widget? itemResults;

  @override
  void initState() {
    super.initState();
    customSearchBar = const Text("Discover");
    itemResults = FutureBuilder<Results>(
      future: TankobonClient.getManga(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.65,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (_, index) => ItemResult(snapshot.data!.manga![index]),
            itemCount: snapshot.data!.manga!.length,
          );
        } else {
          return const Center(child: CircularProgressIndicator(color: Colors.white,));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        leading: const Icon(LineIcons.book),
        title: customSearchBar,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == LineIcons.search) {
                  // Perform set of instructions.
                  customIcon = const Icon(Icons.clear);
                  customSearchBar = Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: TextField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 33, 37, 41),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            color: Colors.black12,
                          ),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (query) {
                          setState(() {
                            itemResults = FutureBuilder<Results>(
                              future: TankobonClient.getManga(query: query),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 0.65,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    itemBuilder: (_, index) => ItemResult(snapshot.data!.manga![index]),
                                    itemCount: snapshot.data!.manga?.length,
                                  );
                                } else {
                                  return const Center(child: CircularProgressIndicator(color: Colors.black,));
                                }
                              },
                            );
                          });
                        },
                      ),
                    ),
                  );
                } else {
                  customIcon = const Icon(LineIcons.search);
                  customSearchBar = const Text("Discover");
                }
              });
            },
            icon: customIcon,
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: itemResults,
    );
  }
}
