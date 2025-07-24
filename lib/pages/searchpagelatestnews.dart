import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  // Dummy data for demonstration. You should replace this with your actual data source.
  final List<String> _allNewsArticles = [
    'The Mental Health Awareness Toolkit',
    'Community Outreach Program a Success',
    'New Donations to Fund Youth Projects',
    'Volunteer Spotlight: John Doe',
    'Upcoming Events and Workshops',
  ];

  @override
  void initState() {
    super.initState();
    // Initially, show all articles or a subset.
    _searchResults = _allNewsArticles;
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        // If the query is empty, show all articles.
        _searchResults = _allNewsArticles;
      });
      return;
    }
    setState(() {
      _searchResults = _allNewsArticles
          .where((article) => article.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 135, 242),
        iconTheme: const IconThemeData(color: Colors.white),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search for news articles...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 18),
          onChanged: _performSearch,
        ),
      ),
      body: _searchResults.isEmpty
          ? const Center(
              child: Text('No results found.'),
            )
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final article = _searchResults[index];
                return ListTile(
                  title: Text(article),
                  onTap: () {
                    // TODO: Navigate to the specific article details page
                    // For now, we can just pop and maybe pass the result back
                    // or navigate to a detail screen.
                    print('Tapped on: $article');
                    Navigator.pushNamed(context, '/readmorelatestnews');
                  },
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
