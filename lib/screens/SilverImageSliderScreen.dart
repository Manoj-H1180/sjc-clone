import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';

class SilverImageSliderScreen extends StatefulWidget {
  @override
  _SilverImageSliderScreenState createState() =>
      _SilverImageSliderScreenState();
}

class _SilverImageSliderScreenState extends State<SilverImageSliderScreen> {
  int _current = 0;

  final List<String> imageUrls = [
    'assets/slider/silver/image-1.jpg',
    'assets/slider/silver/image-2.jpg',
    'assets/slider/silver/image-3.jpg',
    'assets/slider/silver/image-4.jpg',
    'assets/slider/silver/image-5.jpg',
    'assets/slider/silver/image-6.jpg',
    'assets/slider/silver/image-7.jpg',
    'assets/slider/silver/image-8.jpg',

    // Add more image URLs
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height,
                    viewportFraction: 1.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: imageUrls.map((url) {
                    print(url);
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            Share.share(url, subject: 'Check out this image!');
                          },
                          child: Container(
                            child: Image.asset(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                // Dots Indicator with Animation
                Positioned(
                  bottom: 16.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageUrls.map((url) {
                      int index = imageUrls.indexOf(url);
                      return Transform.translate(
                        offset: Offset(0, _current == index ? -3.0 : 0.0),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                Color.fromARGB(255, 235, 180, 14).withOpacity(
                              _current == index ? 0.9 : 0.4,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
