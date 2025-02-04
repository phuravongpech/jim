import 'package:flutter/material.dart';
import 'package:jim/models/exercise.dart';
import 'package:jim/services/cache_service.dart';
import 'package:jim/services/exercise_service.dart';
import 'package:logger/logger.dart';
import 'widgets/exercise_card.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final log = Logger();

  final ExerciseService exerciseService = ExerciseService();
  final CacheService cacheService = CacheService();
  List<Exercise> exercises = [];
  List<Exercise> favoriteExercises = [];
  bool isLoading = false;
  String? error;
  int currentPage = 0;
  final int itemPerPage = 30;
  bool showFavorite = false;
  String? currentBodyPart = 'back';

  final ScrollController _scrollController = ScrollController();
  String searchQuery = "";
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    loadFavoriteExercises();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      loadMoreExercises();
    }
  }

  Future<void> loadInitialExercises() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
        currentPage = 0;
        exercises.clear();
      });
      final initialExercises = await exerciseService.getExercises(
          bodyPart: currentBodyPart!, page: currentPage, limit: itemPerPage);

      setState(() {
        exercises.addAll(initialExercises);
        currentPage++;
        isLoading = false;
      });
      log.d('Initial exercises for $currentBodyPart loaded');
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
      log.e('Error loading exercises: $e');
    }
  }

  Future<void> loadMoreExercises() async {
    if (isLoading || isLoadingMore) return;

    try {
      setState(() => isLoadingMore = true);

      final newExercises = await exerciseService.getExercises(
          bodyPart: currentBodyPart!, page: currentPage, limit: itemPerPage);

      setState(() {
        exercises.addAll(newExercises);
        currentPage++;
        isLoadingMore = false;
      });
      log.d('More exercises for $currentBodyPart loaded');
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoadingMore = false;
      });
      log.e('Error loading more exercises: $e');
    }
  }

  Future<void> loadFavoriteExercises() async {
    try {
      final favorites = await cacheService.getFavorites();
      setState(() {
        favoriteExercises = favorites;
      });
      log.d('Favorites loaded');
    } catch (e) {
      log.e('Error loading favorites: $e');
    }
  }

  void _filterExercises(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  void toogleShowFavorite() {
    setState(() {
      showFavorite ? showFavorite = false : showFavorite = true;
    });
    loadFavoriteExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Light gray background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Exercise Library',
          style: TextStyle(
            color: Color(0xFF2D3142),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchAndFilterSection(),
          Expanded(
            child: showFavorite ? _buildFavBody() : _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    onChanged: _filterExercises,
                    decoration: const InputDecoration(
                      hintText: 'Search exercises...',
                      hintStyle: TextStyle(color: Color(0xFF9BA3B2)),
                      prefixIcon: Icon(Icons.search, color: Color(0xFF9BA3B2)),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 8, left: 8, top: 6, bottom: 6),
                  child: IconButton(
                    onPressed: toogleShowFavorite,
                    icon: Icon(
                      showFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 24,
                      color:
                          showFavorite ? Colors.red : const Color(0xFF9BA3B2),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 12),
          _buildModernDropdown(),
        ],
      ),
    );
  }

  Widget _buildModernDropdown() {
    final Map<String, IconData> bodyPartIcons = {
      'back': Icons.accessibility_new,
      'cardio': Icons.directions_run,
      'chest': Icons.fitness_center,
      'lower arms': Icons.sports_gymnastics,
      'lower legs': Icons.accessibility,
      'neck': Icons.height,
      'shoulders': Icons.accessibility_new,
      'upper arms': Icons.sports_gymnastics,
      'upper legs': Icons.accessibility,
      'waist': Icons.accessibility_new,
    };

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentBodyPart,
          hint: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Select body part',
              style: TextStyle(
                color: Color(0xFF9BA3B2),
                fontSize: 16,
              ),
            ),
          ),
          isExpanded: true,
          icon: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2D3142),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          dropdownColor: Colors.white,
          items: bodyPartIcons.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E5EA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        entry.value,
                        size: 20,
                        color: const Color(0xFF2D3142),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      entry.key
                          .split(' ')
                          .map((word) =>
                              word[0].toUpperCase() + word.substring(1))
                          .join(' '),
                      style: const TextStyle(
                        color: Color(0xFF2D3142),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              currentBodyPart = value!;
              isLoading = true;
            });
            loadInitialExercises();
          },
        ),
      ),
    );
  }

  Widget _buildFavBody() {
    if (favoriteExercises.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: Colors.grey.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            const Text(
              'No favorite exercises',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF9BA3B2),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: loadFavoriteExercises,
      color: const Color(0xFF2D3142),
      child: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 8),
        children: [
          if (favoriteExercises.isNotEmpty)
            _buildSection('Favorites', favoriteExercises),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (currentBodyPart == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 64,
              color: Colors.grey.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select a body part to see exercises',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF9BA3B2),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2D3142)),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading ${currentBodyPart!.split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ')} exercises...',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF9BA3B2),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error: $error',
              style: const TextStyle(
                color: Color(0xFF2D3142),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loadInitialExercises,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D3142),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: loadInitialExercises,
      color: const Color(0xFF2D3142),
      child: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 8),
        children: [
          if (exercises.isNotEmpty) _buildSection(currentBodyPart!, exercises),
          if (isLoadingMore)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2D3142)),
                ),
              ),
            ),
          if (exercises.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No exercises found',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF9BA3B2),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Exercise> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            title
                .split(' ')
                .map((word) => word[0].toUpperCase() + word.substring(1))
                .join(' '),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3142),
            ),
          ),
        ),
        ...items.map((exercise) => ExerciseScreenCard(
              exercise: exercise,
              onFavoriteReload: loadFavoriteExercises,
            )),
      ],
    );
  }
}
