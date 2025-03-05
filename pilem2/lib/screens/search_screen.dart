import 'package:flutter/material.dart';
import 'package:pilem2/models/movie.dart';
import 'package:pilem2/screens/detail_screen.dart';
import 'package:pilem2/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController searchController = TextEditingController();
  List<Movie> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(searchMovies);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchMovies() async {
    if (searchController.text.isEmpty) {
      setState(() {
        searchResults.clear();
      });
      return;
    }

    final List<Map<String, dynamic>> searchData = await apiService.searchMovies(searchController.text);
    setState(() {
      searchResults = searchData.map((e) => Movie.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search movies...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: searchController.text.isNotEmpty,
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          searchResults.clear();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final Movie movie = searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(movie.title),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(movie: movie),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
