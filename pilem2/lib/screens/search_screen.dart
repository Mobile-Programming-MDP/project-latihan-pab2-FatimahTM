import 'package:flutter/material.dart';
import 'package:pilem2/screens/detail_screen.dart';
import 'package:pilem2/services/api_service.dart';
import 'package:pilem2/models/movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResult = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchMovies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchMovies() async {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResult.clear();
      });
      return;
    }

    final List<Map<String, dynamic>> searchData =
        await _apiService.searchMovies(_searchController.text);
    setState(() {
      _searchResult = searchData.map((e) => Movie.fromJson(e)).toList();
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
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                        hintText: 'Search movies ...',
                        border: InputBorder.none),
                  )),
                  Visibility(
                      visible: _searchController.text.isNotEmpty,
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResult.clear();
                          });
                        },
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, index) {
                final Movie movie = _searchResult[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: Image.network(
                      movie.posterPath != ''
                          ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                          : 'https://via.placeholder.com/50x50.png?text=No+Image',
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
                          ));
                    },
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}