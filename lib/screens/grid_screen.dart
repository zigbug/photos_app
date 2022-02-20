import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photos_app/screens/photo_screen_selected.dart';

import 'package:photos_app/servises/fetch_photos_list.dart';

class GridScreenPhotos extends StatefulWidget {
  const GridScreenPhotos({Key? key}) : super(key: key);

  @override
  _GridScreenPhotosState createState() => _GridScreenPhotosState();
}

class _GridScreenPhotosState extends State<GridScreenPhotos> {
  late ScrollController _scrollController;

  int _itemsForNow = 20;
  int maxItems = photos.length;
  bool endOfStory = false;
  bool isLoading = false;

  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        if (_itemsForNow != maxItems) {
          _itemsForNow += 10;
        } else {
          endOfStory = true;
        }
      });
    } else {
      setState(() {
        print('Reach the bottom');
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      child: Column(
        children: [
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _itemsForNow,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PhotoScreen(imagePath: photos[index])));
                  },
                  child: CachedNetworkImage(
                    imageUrl: photos[index],
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) => GestureDetector(
                        onTap: () {}, child: Image.asset('noPhoto.png')),
                  ),
                );
              }),
          if (endOfStory)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: SizedBox(
                      height: 40,
                      child: Material(child: Text('End Of Story :((')))),
            )
        ],
      ),
    );
  }
}
