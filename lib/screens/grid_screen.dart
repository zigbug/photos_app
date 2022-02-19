import 'package:flutter/material.dart';
import 'package:photos_app/screens/photo_screen_selected.dart';

import 'package:photos_app/servises/fetch_photos_list.dart';

class GrindScreenPhotos extends StatefulWidget {
  const GrindScreenPhotos({Key? key}) : super(key: key);

  @override
  _GrindScreenPhotosState createState() => _GrindScreenPhotosState();
}

// Future _loadMoreItems() async {
//   final totalItems = items.length;
//   await Future.delayed(Duration(seconds: 3), () {
//     for (var i = 0; i < _numItemsPage; i++) {
//       items.add(Item('Item ${totalItems + i + 1}'));
//     }
//   });

//   _hasMoreItems = items.length < _maxItems;
// }

class _GrindScreenPhotosState extends State<GrindScreenPhotos> {
  late ScrollController _scrollController;
//late Listener _scrollListener;
  int _itemsForNow = 10;
  int maxItems = photos.length;
  bool endOfStory = false;

  // Listening for user scroll on screen.
  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        print('Add 10');
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
      controller: _scrollController,
      child: Column(
        children: [
          GridView.builder(
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
                  child: Image.network(
                    photos[index],
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset('noPhoto.png'),
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
