import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final ScrollController _scrollController = ScrollController();

  // API stuff
  int limit = 8;
  int offset = 0;
  String query = '';
  bool moreResults = true;
  bool firstLoad = false;
  bool loading = false;
  List<Manga> manga = [];

  void initLoad() async {
    setState(() {
      firstLoad = true;
    });

    try {
      var results = await TankobonClient.getManga(
          query: query, limit: limit, offset: offset);
      setState(() {
        manga.addAll(results.manga!);
        if (results.total == manga.length) {
          moreResults = false;
        }
        firstLoad = false;
      });
    } catch (error) {
      Fluttertoast.showToast(
        msg: "There was an error. Try again later.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).colorScheme.primary,
        textColor: const Color.fromARGB(255, 33, 37, 41),
        fontSize: 16.0,
      );
    }
  }

  void loadMore() async {
    if (firstLoad == false && loading == false && moreResults == true) {
      setState(() {
        loading = true;
      });

      offset += limit;

      try {
        var results = await TankobonClient.getManga(
            query: query, limit: limit, offset: offset);
        var newManga = results.manga;
        setState(() {
          manga.addAll(newManga!);
          loading = false;
          if (results.total == manga.length || results.manga?.isEmpty == true) {
            moreResults = false;
          }
        });
      } catch (error) {
        Fluttertoast.showToast(
          msg: "There was an error. Try again later.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: const Color.fromARGB(255, 33, 37, 41),
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    customSearchBar = const Text("Discover");

    initLoad();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                          onSubmitted: (q) {
                            // Use the new implementation
                            query = q;
                            offset = 0 - limit;
                            moreResults = true;
                            manga.clear();
                            loadMore();
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
        body: firstLoad
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 82, 218, 171),
                ),
              )
            : Column(
                children: [
                  Flexible(
                    child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                      itemBuilder: (_, index) => ItemResult(manga[index]),
                      itemCount: manga.length,
                    ),
                  ),
                  if (loading == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 82, 218, 171),
                        ),
                      ),
                    ),
                ],
              ));
  }
}
