import 'package:flutter/material.dart';

class Searchpageblogs extends StatefulWidget {
  const Searchpageblogs({super.key});

  @override
  State<Searchpageblogs> createState() => _SearchpageblogsState();
}

class _SearchpageblogsState extends State<Searchpageblogs> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  // Dummy data for demonstration. You should replace this with your actual data source.
  final List<String> _allBlogArticles = [
    'Story: I remember stumbling upon Elim Trust Blogs dur...',
    'Article: Hope in Action: How Elim Trust is Changing Lives, One Step at a Time.',
    'The Power of Community Volunteering',
    'Mental Wellness Tips for a Better Life',
    'Our Latest Outreach Success Story',
  ];

  @override
  void initState() {
    super.initState();
    // Initially, show all articles or a subset.
    _searchResults = _allBlogArticles;
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        // If the query is empty, show all articles.
        _searchResults = _allBlogArticles;
      });
      return;
    }
    setState(() {
      _searchResults = _allBlogArticles
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
            hintText: 'Search for blogs...',
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
                    // You can add more specific navigation based on the article.
                    Navigator.pushNamed(context, '/readmoreblogs');
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
