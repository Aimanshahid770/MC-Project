



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'search_page.dart'; // Import the SearchPage here
import 'collection_page.dart';

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BooksApp(),
    );
  }
}

class BooksApp extends StatefulWidget {
  const BooksApp({Key? key}) : super(key: key);

  @override
  _BooksAppState createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  List<dynamic> volumes = [];

  @override
  void initState() {
    super.initState();
    fetchVolumes();
  }

  Future<void> fetchVolumes() async {
    const url =
        'https://www.googleapis.com/books/v1/volumes?q=english:&cooking=full&maxResults=30&key=AIzaSyDxxmKptXaexBekdvDGVi0MdF3N-KXacBI';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          volumes = data['items'] ?? [];
        });
      } else {
        print('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching books: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> recommendedBooks = volumes.take(8).toList();
    List<dynamic> newReleasesBooks = volumes.skip(8).toList();

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text(
          'ReadEase',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Recommended for you',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedBooks.length,
                itemBuilder: (context, index) {
                  final volume = recommendedBooks[index];
                  final volumeInfo = volume['volumeInfo'] ?? {};
                  final accessInfo = volume['accessInfo'] ?? {};

                  String? imageUrl;
                  if (volumeInfo['imageLinks'] != null) {
                    String proxy = "https://corsproxy.io/?";
                    imageUrl = "$proxy${volumeInfo['imageLinks']['smallThumbnail']}";
                  }

                  return Container(
                    width: 220,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          if (imageUrl != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Image.network(
                                imageUrl,
                                width: 150,
                                height: 190,
                                fit: BoxFit.cover,
                              ),
                            ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              volumeInfo['title'] ?? 'No Title',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Spacer(),
                          if (accessInfo['pdf'] != null &&
                              accessInfo['pdf']['downloadLink'] != null)
                            ElevatedButton(
                              onPressed: () {
                                _launchURL(accessInfo['pdf']['downloadLink']);
                              },
                              child: const Text('View PDF'),
                            ),
                          ElevatedButton(
                            onPressed: () {
                              final bookUrl =
                                  'https://books.google.com/books?id=${volume['id']}';
                              _launchURL(bookUrl);
                            },
                            child: const Text('View on Google Books'),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'New Releases',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: newReleasesBooks.length,
              itemBuilder: (context, index) {
                final volume = newReleasesBooks[index];
                final volumeInfo = volume['volumeInfo'] ?? {};
                final accessInfo = volume['accessInfo'] ?? {};

                String? imageUrl;
                if (volumeInfo['imageLinks'] != null) {
                  String proxy = "https://corsproxy.io/?";
                  imageUrl = "$proxy${volumeInfo['imageLinks']['smallThumbnail']}";
                }

                return Container(
                  height: 200,
                  margin: const EdgeInsets.all(10.0),
                  child: Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        if (imageUrl != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Image.network(
                              imageUrl,
                              width: 100,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                volumeInfo['title'] ?? 'No Title',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              if (accessInfo['pdf'] != null &&
                                  accessInfo['pdf']['downloadLink'] != null)
                                ElevatedButton(
                                  onPressed: () {
                                    _launchURL(accessInfo['pdf']['downloadLink']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(100, 35),
                                  ),
                                  child: const Text('View PDF'),
                                ),
                              ElevatedButton(
                                onPressed: () {
                                  final bookUrl =
                                      'https://books.google.com/books?id=${volume['id']}';
                                  _launchURL(bookUrl);
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(100, 35),
                                ),
                                child: const Text('View on Google Books'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar:BottomNavigationBar(
  currentIndex: 0,
  onTap: (index) {
    if (index == 1) { // When Explore icon is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      );
    } else if (index == 2) { // When My Collection icon is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CollectionPage()), // Navigate to CollectionPage
      );
    }
  },
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmark),
      label: 'My Collection',
    ),
  ],
)

    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}






































