import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

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
    var poster = GestureDetector(
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
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );

    var header = Container(
      margin: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 82, 185, 185),
            Color.fromARGB(255, 82, 218, 171)
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(75),
        child: Center(
          child: Column(
            children: [
              poster,
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.item.name ?? '',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            ],
          ),
        ),
      ),
    );

    var summary = Container(
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 25),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(32, 0, 0, 0)),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Color.fromARGB(8, 0, 0, 0),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'About',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              // borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(32, 0, 0, 0),
                ),
                top: BorderSide(
                  color: Color.fromARGB(32, 0, 0, 0),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.item.description ?? '',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              // borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              border: Border(
                  bottom: BorderSide(color: Color.fromARGB(32, 0, 0, 0))),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    children: [
                      const TextSpan(
                        text: "Volumes: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: widget.item.volumeCount.toString()),
                    ]),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              // borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              border: Border(
                  bottom: BorderSide(color: Color.fromARGB(32, 0, 0, 0))),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    children: [
                      const TextSpan(
                        text: "Status: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: widget.item.status),
                    ]),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              // borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              border: Border(
                  bottom: BorderSide(color: Color.fromARGB(32, 0, 0, 0))),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    children: [
                      const TextSpan(
                        text: "Start Date: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: widget.item.startDate),
                    ]),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              // borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              border: Border(
                  bottom: BorderSide(color: Color.fromARGB(32, 0, 0, 0))),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    children: [
                      const TextSpan(
                        text: "Serialization: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: widget.item.magazine),
                    ]),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: buildExternalLinks(),
          ),
        ],
      ),
    );

    var volumes = FutureBuilder<List<Volume>>(
      future: TankobonClient.getVolumes(widget.item.id ?? 0),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.fromLTRB(25, 0, 25, 25),
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
              shrinkWrap: true,
              primary: false,
              itemBuilder: (_, index) =>
                  VolumeChip(volume: snapshot.data![index]),
              itemCount: snapshot.data!.length,
            ),
          );
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 82, 218, 171),
              ),
            ),
          );
        }
      },
    );

    return Scaffold(
      appBar: GradientAppBar(
        title: Text(widget.item.name ?? ''),
        actions: [
          IconButton(
            onPressed: () {
              _launchUrl("https://tankobon.fly.dev/manga/${widget.item.id}/");
            }, 
            icon: const Icon(LineIcons.globe),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            header,
            summary,
            volumes,
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  Widget buildExternalLinks() {
    // AniList
    Widget? anilist;
    if (widget.item.anilistId != null) {
      anilist = Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GestureDetector(
          onTap: () {
            _launchUrl("https://anilist.co/manga/${widget.item.anilistId}");
          },
          child: const Chip(
            label: Text(
              "AniList",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 11, 22, 34),
          ),
        ),
      );
    }

    // MAL
    Widget? mal;
    if (widget.item.malId != null) {
      mal = Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GestureDetector(
          onTap: () {
            _launchUrl("https://myanimelist.net/manga/${widget.item.malId}");
          },
          child: const Chip(
            label: Text(
              "MyAnimeList",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 46, 81, 162),
          ),
        ),
      );
    }

    // MangaUpdates
    Widget? mangaupdates;
    if (widget.item.mangaupdatesId != null) {
      mangaupdates = Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GestureDetector(
          onTap: () {
            _launchUrl("https://www.mangaupdates.com/series.html?id=${widget.item.mangaupdatesId}");
          },
          child: const Chip(
            label: Text(
              "MangaUpdates",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 82, 102, 124),
          ),
        ),
      );
    }

    // AnimePlanet
    Widget? animeplanet;
    if (widget.item.animePlanetSlug != null) {
      animeplanet = Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GestureDetector(
          onTap: () {
            _launchUrl("https://www.anime-planet.com/manga/${widget.item.animePlanetSlug}");
          },
          child: const Chip(
            label: Text(
              "AnimePlanet",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 252, 83, 66),
          ),
        ),
      );
    }

    // Kitsu
    Widget? kitsu;
    if (widget.item.kitsuId != null) {
      kitsu = Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GestureDetector(
          onTap: () {
            _launchUrl("https://kitsu.io/manga/${widget.item.kitsuId}");
          },
          child: const Chip(
            label: Text(
              "Kitsu",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 72, 48, 72),
          ),
        ),
      );
    }

    // Fandom
    Widget? fandom;
    if (widget.item.fandom != null) {
      fandom = GestureDetector(
        onTap: () {
          _launchUrl(widget.item.fandom ?? '');
        },
        child: const Chip(
          label: Text(
            "Fandom",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 250, 0, 90),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (anilist != null) anilist,
            if (mal != null) mal,
            if (mangaupdates != null) mangaupdates,
            if (animeplanet != null) animeplanet,
            if (kitsu != null) kitsu,
            if (fandom != null) fandom,
          ],
        ),
      ),
    );
  }
}
