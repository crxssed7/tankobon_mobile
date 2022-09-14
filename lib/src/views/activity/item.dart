import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:tankobon_mobile/src/api/models/models.dart';
import 'package:tankobon_mobile/src/api/client.dart';
// import 'package:tankobon_mobile/src/views/widget/item_result.dart';
import 'package:tankobon_mobile/src/views/widget/gradient_app_bar.dart';
import 'package:tankobon_mobile/src/views/widget/volume.dart';

class ItemActivity extends StatefulWidget {
  final Manga item;

  const ItemActivity(this.item, {Key? key}) : super(key: key);

  @override
  State<ItemActivity> createState() => _ItemActivityState();
}

class _ItemActivityState extends State<ItemActivity> {
  @override
  Widget build(BuildContext context) {
    var poster = SizedBox(
      width: 104,
      height: 160,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Cover',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                content: CachedNetworkImage(
                  imageUrl: widget.item.poster ?? '',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
                backgroundColor: Theme.of(context).colorScheme.background,
                scrollable: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            },
          );
        },
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl: widget.item.poster ?? '',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    var header = Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          poster,
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.name ?? '',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Status: ${widget.item.status ?? "Unknown"}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Start Date: ${widget.item.startDate ?? "Unknown"}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Serialization: ${widget.item.magazine ?? "Unknown"}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    var summary = Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Summary',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                content: Text(
                  widget.item.description ?? '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.background,
                scrollable: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            },
          );
        },
        child: Text(
          widget.item.description ?? 'No summary',
          maxLines: 3,
          overflow: TextOverflow.fade,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );

    var volumes = FutureBuilder<List<Volume>>(
      future: TankobonClient.getVolumes(widget.item.id ?? 0),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (_, index) =>
                VolumeChip(volume: snapshot.data![index]),
            itemCount: snapshot.data!.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 82, 218, 171),
            ),
          );
        }
      },
    );

    return Scaffold(
      appBar: GradientAppBar(
        title: Text(widget.item.name ?? ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            header,
            summary,
            volumes,
            // buildChapterList(),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

/*   Widget buildChapterList() {
    var chapters = widget.item.chapters?.map((chapter) {
      return ChapterButton(chapter, widget.sourceType);
    }).toList();

    if (chapters != null) {
      return Column(
        children: chapters,
      );
    } else {
      return const Text("No chapters found");
    }
  } */
}
