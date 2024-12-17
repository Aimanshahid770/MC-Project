


// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';  // Import url_launcher

// class SearchPage extends StatefulWidget {
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   List<dynamic> _searchResults = [];
//   String _errorMessage = '';

//   // Function to fetch books based on the search query
//   Future<void> searchBooks(String query) async {
//     final url = Uri.parse(
//         'https://www.googleapis.com/books/v1/volumes?q=title:$query&filter=full&maxResults=20&key=AIzaSyDxxmKptXaexBekdvDGVi0MdF3N-KXacBI');

//     try {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Extract items from the response, ensuring it's a list
//         final List<dynamic> items = data['items'] ?? [];

//         setState(() {
//           _searchResults = items;
//           _errorMessage = items.isEmpty ? 'No books found.' : '';
//         });
//       } else {
//         setState(() {
//           _errorMessage = 'Error fetching data. Please try again.';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Something went wrong: $e';
//       });
//     }
//   }

//   // Function to open the book link in a browser
//   Future<void> _launchBookUrl(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Search Books')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // TextField for user input
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Search for a book',
//                 border: OutlineInputBorder(),
//               ),
//               onSubmitted: searchBooks, // Calls searchBooks when Enter is pressed
//             ),
//             SizedBox(height: 16),
//             // Display search results or messages
//             Expanded(
//               child: _searchResults.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: _searchResults.length,
//                       itemBuilder: (context, index) {
//                         final book = _searchResults[index];
//                         final bookInfo = book['volumeInfo'] ?? {};
//                         final bookTitle = bookInfo['title'] ?? 'No title';
//                         final bookAuthors =
//                             (bookInfo['authors'] as List?)?.join(', ') ??
//                                 'Unknown author';
//                         final bookImage = bookInfo['imageLinks']?['smallThumbnail'] ?? '';
//                         final previewLink = bookInfo['previewLink'] ?? '';

//                         // Fetch image through the proxy
//                         String? imageUrl;
//                         if (bookImage.isNotEmpty) {
//                           String proxy = "https://corsproxy.io/?";
//                           imageUrl = "$proxy$bookImage";
//                         }

//                         return Card(
//                           margin: EdgeInsets.symmetric(vertical: 8.0),
//                           child: InkWell(
//                             onTap: () {
//                               if (previewLink.isNotEmpty) {
//                                 _launchBookUrl(previewLink);
//                               }
//                             },
//                             child: ListTile(
//                               leading: imageUrl != null
//                                   ? Image.network(
//                                       imageUrl,
//                                       width: 50,
//                                       height: 50,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : Icon(Icons.book),
//                               title: Text(bookTitle),
//                               subtitle: Text(bookAuthors),
//                             ),
//                           ),
//                         );
//                       },
//                     )
//                   : Center(
//                       child: Text(
//                         _errorMessage.isEmpty
//                             ? 'Enter a book name to search.'
//                             : _errorMessage,
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';  // Import url_launcher

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> _searchResults = [];
  String _errorMessage = '';

  // Function to fetch books based on the search query
  Future<void> searchBooks(String query) async {
    final url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=title:$query&filter=full&maxResults=20&key=AIzaSyDxxmKptXaexBekdvDGVi0MdF3N-KXacBI');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract items from the response, ensuring it's a list
        final List<dynamic> items = data['items'] ?? [];

        setState(() {
          _searchResults = items;
          _errorMessage = items.isEmpty ? 'No books found.' : '';
        });
      } else {
        setState(() {
          _errorMessage = 'Error fetching data. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Something went wrong: $e';
      });
    }
  }

  // Function to open the book link in a browser
  Future<void> _launchBookUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Books')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField for user input with rounded corners and search icon
            TextField(
              decoration: InputDecoration(
                labelText: 'Search for a book',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25), // Rounded corners
                ),
                prefixIcon: Icon(Icons.search), // Search icon
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              onSubmitted: searchBooks, // Calls searchBooks when Enter is pressed
            ),
            SizedBox(height: 16),
            // Display search results or messages
            Expanded(
              child: _searchResults.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final book = _searchResults[index];
                        final bookInfo = book['volumeInfo'] ?? {};
                        final bookTitle = bookInfo['title'] ?? 'No title';
                        final bookAuthors =
                            (bookInfo['authors'] as List?)?.join(', ') ?? 'Unknown author';
                        final bookImage = bookInfo['imageLinks']?['smallThumbnail'] ?? '';
                        final previewLink = bookInfo['previewLink'] ?? '';

                        // Fetch image through the proxy
                        String? imageUrl;
                        if (bookImage.isNotEmpty) {
                          String proxy = "https://corsproxy.io/?";
                          imageUrl = "$proxy$bookImage";
                        }

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 4, // Shadow effect for the list items
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Rounded corners
                            side: BorderSide(color: Colors.black12, width: 1), // Border for the item
                          ),
                          child: InkWell(
                            onTap: () {
                              if (previewLink.isNotEmpty) {
                                _launchBookUrl(previewLink);
                              }
                            },
                            child: ListTile(
                              leading: imageUrl != null
                                  ? Image.network(
                                      imageUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(Icons.book),
                              title: Text(
                                bookTitle,
                                style: TextStyle(fontWeight: FontWeight.bold), // Bold book title
                              ),
                              subtitle: Text(bookAuthors),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        _errorMessage.isEmpty
                            ? 'Enter a book name to search.'
                            : _errorMessage,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
