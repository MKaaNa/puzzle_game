import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/game/screens/game_screen.dart';
import 'features/auth/screens/main_menu_screen.dart';
import 'features/settings/screens/settings_screen.dart';
import 'features/settings/providers/settings_provider.dart';
import 'features/game/models/game_state.dart';
import 'features/game/models/game_difficulty.dart';
import 'features/game/widgets/puzzle_grid.dart';
import 'features/game/providers/game_provider.dart';
import 'core/providers/locale_provider.dart';
import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    ProviderScope(
      overrides: [
        settingsProvider.overrideWith((ref) => SettingsNotifier(prefs)),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    
    return MaterialApp(
      title: 'Sliding Puzzle',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(settings.language),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenuScreen(),
        '/game': (context) => const GameScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}

class PuzzleGameScreen extends ConsumerWidget {
  const PuzzleGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sliding Puzzle',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          // Leaderboard button
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () {
              Navigator.pushNamed(context, '/leaderboard');
            },
            tooltip: 'Leaderboard',
          ),
          // Pause/Resume button (only shown when game is in progress or paused)
          if (gameState.status == GameStatus.inProgress || 
              gameState.status == GameStatus.paused)
            IconButton(
              icon: Icon(
                gameState.status == GameStatus.paused
                    ? Icons.play_arrow
                    : Icons.pause,
              ),
              onPressed: () => ref.read(gameProvider.notifier).togglePause(),
              tooltip: gameState.status == GameStatus.paused
                  ? 'Resume Game'
                  : 'Pause Game',
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Game stats panel
            _buildGameStatsPanel(context, gameState),
            
            // Main puzzle grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: gameState.status == GameStatus.paused
                    ? const Center(
                        child: Text(
                          'GAME PAUSED',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : PuzzleGrid(
                        puzzle: _convertTilesToGrid(gameState.tiles),
                        onTileTap: (row, col) {
                          final index = row * sqrt(gameState.tiles.length).toInt() + col;
                          ref.read(gameProvider.notifier).moveTile(index);
                        },
                        correctPositions: _convertCorrectPositions(gameState.correctPositions),
                      ),
              ),
            ),
            
            // Game controls
            _buildGameControls(context, ref),
            
            // High scores section
            _buildHighScoresPanel(context, gameState),
          ],
        ),
      ),
    );
  }

  Widget _buildGameStatsPanel(BuildContext context, GameState gameState) {
    final isGameActive = gameState.status == GameStatus.inProgress ||
                        gameState.status == GameStatus.paused;
    
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Moves counter
              _buildStatDisplay(
                context, 
                'Moves', 
                isGameActive ? '${gameState.moveCount}' : '-',
                Icons.swap_horiz,
              ),
              
              // Game timer
              _buildStatDisplay(
                context, 
                'Time', 
                isGameActive ? gameState.formattedTime : '00:00',
                Icons.timer,
              ),
              
              // Current difficulty
              _buildStatDisplay(
                context, 
                'Difficulty', 
                gameState.difficulty.label,
                Icons.grid_3x3,
              ),
            ],
          ),
          
          // Current score
          if (isGameActive)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.stars, color: Colors.amber, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Current Score: ${gameState.score}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatDisplay(
    BuildContext context, 
    String label, 
    String value, 
    IconData icon,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildGameControls(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        children: [
          // New Game button
          ElevatedButton.icon(
            onPressed: () => _showPlayerNameDialog(context, ref),
            icon: const Icon(Icons.refresh),
            label: const Text('New Game'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 44),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighScoresPanel(BuildContext context, GameState gameState) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Current Score',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${gameState.score}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }

  void _showPlayerNameDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Enter Your Name'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Player Name',
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              ref.read(gameProvider.notifier).startNewGame(GameDifficulty.easy);
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref.read(gameProvider.notifier).startNewGame(GameDifficulty.easy);
                Navigator.pop(context);
              }
            },
            child: const Text('Start Game'),
          ),
        ],
      ),
    );
  }

  List<List<int>> _convertTilesToGrid(List<int> tiles) {
    final size = sqrt(tiles.length).toInt();
    final grid = List<List<int>>.generate(size, (_) => List<int>.filled(size, 0));
    for (int i = 0; i < tiles.length; i++) {
      final row = i ~/ size;
      final col = i % size;
      grid[row][col] = tiles[i];
    }
    return grid;
  }

  List<bool> _convertCorrectPositions(List<List<bool>> positions) {
    final result = <bool>[];
    for (final row in positions) {
      result.addAll(row);
    }
    return result;
  }
}
