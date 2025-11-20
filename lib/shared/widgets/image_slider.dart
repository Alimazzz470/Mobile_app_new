import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/dto/image_slider.dart';

class ImageSlider extends StatefulWidget {
  final ImageSliderDto listImagesModel;

  const ImageSlider({super.key, required this.listImagesModel});
  @override
  // ignore: library_private_types_in_public_api
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _current = 0;
  bool _stateChange = false;
  @override
  void initState() {
    super.initState();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    _current = (_stateChange == false)
        ? widget.listImagesModel.initialIndex
        : _current;
    return Container(
      color: const Color.fromARGB(0, 0, 0, 0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              widget.listImagesModel.images.length == 1
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0.0)),
                            child: Image.network(
                              widget.listImagesModel.images[0],
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: false,
                            enableInfiniteScroll: false,
                            height: MediaQuery.of(context).size.height / 1.3,
                            viewportFraction: 1.0,
                            onPageChanged: (index, data) {
                              setState(() {
                                _stateChange = true;
                                _current = index;
                              });
                            },
                            initialPage: widget.listImagesModel.initialIndex,
                          ),
                          items: map<Widget>(
                            widget.listImagesModel.images,
                            (index, String url) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(0.0),
                                    ),
                                    child: Image.network(
                                      url,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: map<Widget>(
                            widget.listImagesModel.images,
                            (index, url) {
                              return Container(
                                width: 10.0,
                                height: 9.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (_current == index)
                                      ? Colors.redAccent
                                      : Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
