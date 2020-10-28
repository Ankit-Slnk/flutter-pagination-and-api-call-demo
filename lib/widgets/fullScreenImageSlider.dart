import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../utility/appAssets.dart';
import '../utility/utiity.dart';

class FullScreenImageSlider extends StatefulWidget {
  final List<String> imagelist;
  final int selectedimage;

  FullScreenImageSlider({
    Key key,
    @required this.imagelist,
    @required this.selectedimage,
  }) : super(key: key);
  @override
  _FullScreenImageSliderState createState() => _FullScreenImageSliderState();
}

class _FullScreenImageSliderState extends State<FullScreenImageSlider> {
  var _current = 0;

  @override
  void initState() {
    super.initState();
    _current = widget.selectedimage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: slider(),
      ),
    );
  }

  slider() {
    return Stack(
      children: <Widget>[
        PhotoViewGallery.builder(
          itemCount: widget.imagelist.length,
          pageController: PageController(
            initialPage: widget.selectedimage,
          ),
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: Utility.imageLoaderImage(
                      widget.imagelist[index], AppAssets.imagePlaceholder)
                  .image,
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 1.8,
            );
          },
          onPageChanged: (index) {
            if (mounted)
              setState(() {
                _current = index;
              });
          },
          backgroundDecoration: BoxDecoration(
            color: Colors.transparent,
          ),
          scrollPhysics: BouncingScrollPhysics(),
          loadingBuilder: (context, event) {
            return Utility.progress(context);
          },
        ),
      ],
    );
  }
}
