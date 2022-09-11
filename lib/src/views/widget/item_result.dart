import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:tankobon_mobile/src/api/client.dart';
import 'package:tankobon_mobile/src/api/models/models.dart';
// import 'package:tankobon_mobile/src/views/activity/item.dart';
// import 'package:tankobon_mobile/src/views/activity/reader.dart';

class ItemResult extends StatelessWidget {
  final Manga item;

  const ItemResult(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        // Get the item details
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              item.poster ?? '',
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
              borderRadius: BorderRadius.circular(8),
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
    );
  }
}