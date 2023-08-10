import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/model/contacts.dart'; // Make sure to import your Contacts model
import 'package:app/screens/GoldImageSliderScreen.dart';
import 'package:app/screens/SilverImageSliderScreen.dart';
import 'package:maps_launcher/maps_launcher.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  final contactList = Contacts.contactList();

  void _showModel(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(
            'Announcement',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          content: title == 'Gold Button'
              ? Text('New scheme Started on December 2021')
              : Text(
                  'Kindly Attention SJC Subscriber/s, This Scheme is only availabe till November 2022. if you are already existing in this scheme you can continue'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Hide the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => title == 'Gold Button'
                        ? GoldImageSliderScreen()
                        : SilverImageSliderScreen(),
                  ),
                );
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showContactModel(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  title == 'Location Details'
                      ? 'Press on the location and get the direction in map'
                      : title == 'Whatsapp Details'
                          ? 'Press on the number to direct whatsapp chat'
                          : 'Press on the number to direct call',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                for (Contacts contact in contactList)
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          contact.city,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  String launchUrl;

                                  if (title == 'Location Details') {
                                    List<String> coordinates =
                                        contact.location.toString().split(',');
                                    double latitude =
                                        double.parse(coordinates[0]);
                                    double longitude =
                                        double.parse(coordinates[1]);

                                    bool launched =
                                        await MapsLauncher.launchCoordinates(
                                            latitude, longitude);

                                    if (launched) {
                                      // Maps launched successfully
                                      launchUrl =
                                          ''; // You can set a default URL or leave it empty
                                    } else {
                                      // Maps launch failed
                                      launchUrl =
                                          ''; // You can set an alternative URL or leave it empty
                                    }
                                  } else if (title == 'Whatsapp Details') {
                                    launchUrl =
                                        'https://wa.me/+91:${contact.contact1}';
                                  } else {
                                    launchUrl = 'tel:${contact.contact1}';
                                  }

                                  onLaunch(launchUrl);
                                },
                                child: Text(
                                  title == 'Location Details'
                                      ? contact.office
                                      : contact.contact1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 2),
                              GestureDetector(
                                onTap: () async {
                                  String launchUrl;

                                  if (title == 'Location Details') {
                                    List<String> coordinates =
                                        contact.location.toString().split(',');
                                    double latitude =
                                        double.parse(coordinates[0]);
                                    double longitude =
                                        double.parse(coordinates[1]);

                                    bool launched =
                                        await MapsLauncher.launchCoordinates(
                                            latitude, longitude);

                                    if (launched) {
                                      // Maps launched successfully
                                      launchUrl =
                                          ''; // You can set a default URL or leave it empty
                                    } else {
                                      // Maps launch failed
                                      launchUrl =
                                          ''; // You can set an alternative URL or leave it empty
                                    }
                                  } else if (title == 'Whatsapp Details') {
                                    launchUrl =
                                        'https://wa.me/+91:${contact.contact2}';
                                  } else {
                                    launchUrl = 'tel:${contact.contact2}';
                                  }

                                  onLaunch(launchUrl);
                                },
                                child: Text(
                                  title == 'Location Details'
                                      ? '- ${contact.city}'
                                      : contact.contact2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              title == 'Location Details'
                                  ? Image.asset(
                                      'assets/images/map.png',
                                      height: 16,
                                      width: 16,
                                    )
                                  : title == 'Whatsapp Details'
                                      ? Image.asset(
                                          'assets/images/whatsapp.png',
                                          height: 20,
                                          width: 20,
                                        )
                                      : Image.asset(
                                          'assets/images/smartphone.png',
                                          width: 20,
                                        ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                title == 'Whatsapp Details' || title == 'Location Details'
                    ? SizedBox.shrink()
                    : Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Toll Free No',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                child: Image.asset(
                                  'assets/images/smartphone.png',
                                  width: 20,
                                ),
                              ),
                              Container(
                                child: IconButton(
                                    onPressed: () {
                                      onLaunch('tel:18004251432');
                                    },
                                    icon: Text(
                                      '1800 425 1432',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ]),
                      )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Hide the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.greenAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      width: 400,
                      height: 130,
                      child: Center(
                        child: Image.asset(
                          'assets/images/logo.jpg',
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 400,
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _showModel(context, 'Gold Button');
                            },
                            icon: Image.asset('assets/images/goldbtn.png'),
                          ),
                          IconButton(
                            onPressed: () {
                              _showModel(context, 'Silver Button');
                            },
                            icon: Image.asset('assets/images/silverbtn.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 100,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      child: IconButton(
                                        onPressed: () {
                                          onLaunch(
                                            'https://www.jayanathanchits.com',
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        },
                                        icon: Image.asset(
                                          'assets/images/world-wide-web.png',
                                          height: 33,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      child: IconButton(
                                        onPressed: () {
                                          onLaunch(
                                            'https://instagram.com/sreejayanathanchits?igshid=NjIwNzIyMDk2Mg==',
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        },
                                        icon: Image.asset(
                                          'assets/images/instagram.png',
                                          height: 33,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      child: IconButton(
                                        onPressed: () {
                                          onLaunch(
                                            'https://www.facebook.com/SjChits/',
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        },
                                        icon: Image.asset(
                                          'assets/images/facebook.png',
                                          height: 33,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      child: IconButton(
                                        onPressed: () {
                                          onLaunch(
                                            'https://youtube.com/@sreejayanathanchits6684',
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        },
                                        icon: Image.asset(
                                          'assets/images/youtube.png',
                                          height: 33,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 45,
                                  child: IconButton(
                                    onPressed: () {
                                      _showContactModel(
                                          context, 'Contact Details');
                                    },
                                    icon: Image.asset(
                                      'assets/images/telephone-call.png',
                                      height: 33,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 46,
                                  child: IconButton(
                                    onPressed: () {
                                      _showContactModel(
                                          context, 'Whatsapp Details');
                                    },
                                    icon: Image.asset(
                                      'assets/images/whatsapp.png',
                                      height: 34,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  child: IconButton(
                                    onPressed: () {
                                      _showContactModel(
                                          context, 'Location Details');
                                    },
                                    icon: Image.asset(
                                      'assets/images/location-pin.png',
                                      height: 32,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void onLaunch(url, {mode = LaunchMode.platformDefault}) async {
  print(url);
  await launch(url,
      forceSafariVC: false,
      forceWebView: false,
      enableJavaScript: true,
      enableDomStorage: true,
      universalLinksOnly: false,
      webOnlyWindowName: '');
}
