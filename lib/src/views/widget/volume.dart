import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:tankobon_mobile/src/api/models/models.dart';

class VolumeChip extends StatelessWidget {
  final Volume volume;

  const VolumeChip({super.key, required this.volume});

  @override
  Widget build(BuildContext context) {
    String volumeText = "Volume ${volume.number}";
    if (volume.number! < 0) {
      volumeText = "Not yet in Tankobon format";
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(32, 0, 0, 0)),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color.fromARGB(8, 0, 0, 0),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: ExpansionTile(
          title: Text(volumeText),
          textColor: Theme.of(context).colorScheme.secondary,
          iconColor: Theme.of(context).colorScheme.secondary,
          collapsedIconColor: Theme.of(context).colorScheme.secondary,
          collapsedTextColor: Theme.of(context).colorScheme.secondary,
          children: [buildChapters()],
        ),
      ),
    );
  }

  Widget buildChapters() {
    Widget? poster;

    if (volume.poster?.isEmpty == false) {
      poster = Center(
        child: SizedBox(
          width: 104,
          height: 160,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: volume.poster ?? '',
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
    }

    var chapters = volume.chapters!.map((e) {
      if (e.startsWith('|')) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "${e.replaceAll('|', '')} arc starts here",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            e,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }
    }).toList();

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [if (poster != null) poster, ...chapters],
      ),
    );
  }
}
