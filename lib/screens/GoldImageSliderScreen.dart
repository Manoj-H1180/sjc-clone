import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class GoldImageSliderScreen extends StatefulWidget {
  @override
  _GoldImageSliderScreenState createState() => _GoldImageSliderScreenState();
}

class _GoldImageSliderScreenState extends State<GoldImageSliderScreen> {
  int _current = 0;

  final List<String> imageUrls = [
    'assets/slider/gold/image-1.jpg',
    'assets/slider/gold/image-2.jpg',
    'assets/slider/gold/image-3.jpg',
    'assets/slider/gold/image-4.jpg',
    'assets/slider/gold/image-5.jpg',
    'assets/slider/gold/image-6.jpg',
    'assets/slider/gold/image-7.jpg',
    'assets/slider/gold/image-8.jpg',
    'assets/slider/gold/image-9.jpg',
    'assets/slider/gold/image-10.jpg',
    'assets/slider/gold/image-11.jpg',
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
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () async {
                            final ByteData data = await rootBundle.load(url);
                            final Directory tempDir =
                                await getTemporaryDirectory();
                            final File tempFile =
                                File('${tempDir.path}/image.jpg');
                            await tempFile
                                .writeAsBytes(data.buffer.asUint8List());

                            Share.shareFiles([tempFile.path],
                                text: 'Check out this image!',
                                subject: 'Image Shared');
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
