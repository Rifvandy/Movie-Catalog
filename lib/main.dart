import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Movie Catalog',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F2937)),
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFFF5F5F7),
          foregroundColor: Color(0xFF222222),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF222222),
          ),
          bodyMedium: TextStyle(
            fontSize: 13,
            color: Color(0xFF7A7A7A),
          ),
        ),
      ),
      home: const MovieCatalogPage(),
    );
  }
}

class MovieCatalogPage extends StatelessWidget {
  const MovieCatalogPage({super.key});

  static const List<MovieItem> movies = [
    MovieItem(
      title: 'Inception',
      releaseDate: '2010',
      rating: '8.8',
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_.jpg',
    ),
    MovieItem(
      title: 'Interstellar',
      releaseDate: '2014',
      rating: '8.7',
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BNTE0MmZiNGEtOGY3NS00NDcyLWFiYTItM2IwMWI4YzBkMzk3XkEyXkFqcGc@._V1_FMjpg_UY4134_.jpg',
    ),
    MovieItem(
      title: 'Tenet',
      releaseDate: '2020',
      rating: '7.3',
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BMjk2Y2M2MWEtYWQxNS00Y2U0LTlhZWQtN2EwM2Q0ODhmMzQ1XkEyXkFqcGc@._V1_QL75_UX220.5_.jpg',
    ),
    MovieItem(
      title: 'The Dark Knight Rises',
      releaseDate: '2012',
      rating: '8.4',
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BMTk4ODQzNDY3Ml5BMl5BanBnXkFtZTcwODA0NTM4Nw@@._V1_SL200_QL1.jpg',
    ),
    MovieItem(
      title: 'Avatar: The Way of Water',
      releaseDate: '2022',
      rating: '7.5',
      imageUrl: 'https://m.media-amazon.com/images/M/MV5BNWI0Y2NkOWEtMmM2OC00MjQ3LWI1YzItZGQxYzQ3NzI4NWZmXkEyXkFqcGc@._V1_QL75_UY562_CR6,0,380,562_.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Catalog'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 4),
              Expanded(
                child: ListView.separated(
                  itemCount: movies.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 22),
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return MovieCard(movie: movie);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieItem {
  const MovieItem({
    required this.title,
    required this.releaseDate,
    required this.rating,
    required this.imageUrl,
  });

  final String title;
  final String releaseDate;
  final String rating;
  final String imageUrl;
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
  });

  final MovieItem movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 84,
            decoration: BoxDecoration(
              color: const Color(0xFFE6E6E9),
              borderRadius: BorderRadius.circular(2),
            ),
            clipBehavior: Clip.antiAlias,
            child: movie.imageUrl.isEmpty
                ? const Center(
                    child: Icon(
                      Icons.movie_creation_outlined,
                      color: Colors.white,
                      size: 26,
                    ),
                  )
                : Image.network(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.white,
                          size: 26,
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  movie.releaseDate,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: Color(0xFFF6C344),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      movie.rating,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF444444),
                            fontWeight: FontWeight.w600,
                          ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
