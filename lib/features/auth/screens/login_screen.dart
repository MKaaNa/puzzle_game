import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../game/screens/game_screen.dart';
import '../../game/models/game_state.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo veya başlık
                  const Icon(
                    Icons.grid_3x3,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Oyun Modları',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // Oyun modları
                  _buildGameModeButton(
                    context,
                    'Klasik Mod',
                    'Geleneksel kaydırmalı bulmaca oyunu',
                    () => _startGame(context, GameMode.classic),
                  ),
                  const SizedBox(height: 16),
                  _buildGameModeButton(
                    context,
                    'Zaman Modu',
                    'Belirli sürede tamamlamaya çalış',
                    () => _startGame(context, GameMode.timeAttack),
                  ),
                  const SizedBox(height: 16),
                  _buildGameModeButton(
                    context,
                    'Hamle Sınırı',
                    'Sınırlı hamle ile tamamlamaya çalış',
                    () => _startGame(context, GameMode.limitedMoves),
                  ),
                  const SizedBox(height: 16),
                  _buildGameModeButton(
                    context,
                    'Günlük Mücadele',
                    'Her gün yeni bir bulmaca',
                    () => _startGame(context, GameMode.dailyChallenge),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameModeButton(
    BuildContext context,
    String title,
    String description,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _startGame(BuildContext context, GameMode mode) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const GameScreen(),
      ),
    );
  }
} 