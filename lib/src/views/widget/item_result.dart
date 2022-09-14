import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:tankobon_mobile/src/api/models/models.dart';
import 'package:tankobon_mobile/src/views/activity/item.dart';
// import 'package:tankobon_mobile/src/views/activity/reader.dart';

class ItemResult extends StatelessWidget {
  final Manga item;

  const ItemResult(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        highlightColor: Theme.of(context).colorScheme.primary,
        splashColor: const Color.fromARGB(255, 82, 218, 171),
        onTap: () {
          // Get the item details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemActivity(item),
            ),
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: item.poster ?? '',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.all(3.5),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(0, 0, 0, 0),
                    Color.fromARGB(175, 0, 0, 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 1],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: AlignmentDirectional.bottomStart,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  item.name ?? '',
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
