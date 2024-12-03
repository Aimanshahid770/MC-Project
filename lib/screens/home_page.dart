import 'package:flutter/material.dart';
import 'search_page.dart';
import 'collection_page.dart'; // Import the My Collection page

class HomePage extends StatelessWidget {
  // Sample data for Recommended Books
  final List<Map<String, String>> recommendedBooks = [
    {
      'title': 'The Great Gatsby',
      'description': 'A classic novel by F. Scott Fitzgerald...',
      'image': 'assets/images/NameWind.jpg',
    },
    {
      'title': '1984',
      'description': 'Dystopian novel by George Orwell...',
      'image': 'assets/images/stepheenking.png',
    },
    {
      'title': 'To Kill a Mockingbird',
      'description': 'A novel by Harper Lee...',
      'image': 'assets/images/Sword.jpg',
    },
    {
      'title': 'Pride and Prejudice',
      'description': 'A romance novel by Jane Austen...',
      'image': 'assets/images/way.jpg',
    },
    {
      'title': 'The Catcher in the Rye',
      'description': 'A novel by J.D. Salinger...',
      'image': 'assets/images/NameWind.jpg',
    },
    {
      'title': 'The Catcher in the Rye',
      'description': 'A novel by J.D. Salinger...',
      'image': 'assets/images/way.jpg',
    },
  ];

  // Sample data for New Releases
  final List<Map<String, String>> newReleases = [
    {
      'title': 'New Horizons',
      'description': 'An exciting sci-fi adventure...',
      'image': 'assets/images/Horizon.jpg',
    },
    {
      'title': 'The Kite Runner',
      'description': 'A thrilling novel...',
      'image': 'assets/images/KiteRunner.jpg',
    },
    {
      'title': 'The Art of Greek Cooking',
      'description': 'Discover new recipes...',
      'image': 'assets/images/GreekCooking.jpg',
    },
    {
      'title': 'And the Mountains Echoed',
      'description': 'Insights on future technology...',
      'image': 'assets/images/Montainsechoed.jpg',
    },
    {
      'title': 'City of the Lost',
      'description': 'Journey through the stars...',
      'image': 'assets/images/CityLost.jpg',
    },
    {
      'title': 'Fantasy Realm',
      'description': 'A magical world awaits...',
      'image': 'assets/images/Horizon.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Ease'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recommended for you',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Handpicked based on your reading preferences.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedBooks.length,
                  itemBuilder: (context, index) {
                    final book = recommendedBooks[index];
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(book['image']!),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              book['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            book['description']!,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'New Releases',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Newly released books spanning various genres.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: newReleases.length,
                  itemBuilder: (context, index) {
                    final book = newReleases[index];
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(book['image']!),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              book['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            book['description']!,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Collection',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue.shade700,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyCollectionPage(),
              ),
            );
          }
        },
      ),
    );
  }
}
