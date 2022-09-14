import 'package:flutter/material.dart';

import 'package:tankobon_mobile/src/api/models/models.dart';

class VolumeChip extends StatelessWidget {
  final Volume volume;

  const VolumeChip({super.key, required this.volume});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Volume ${volume.number}"),
      textColor: Theme.of(context).colorScheme.secondary,
      iconColor: Theme.of(context).colorScheme.secondary,
      collapsedIconColor: Theme.of(context).colorScheme.secondary,
      collapsedTextColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
