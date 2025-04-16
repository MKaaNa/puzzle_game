import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/l10n/app_localizations.dart';
import '../widgets/menu_button.dart';
import '../widgets/mascot_widget.dart';

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with mascot
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    // Background animation
                    Positioned.fill(
                      child: Lottie.asset(
                        'assets/animations/background.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Mascot
                    const Center(
                      child: MascotWidget(),
                    ),
                  ],
                ),
              ),
              
              // Game title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Puzzle Master',
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Menu buttons
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuButton(
                        icon: Icons.play_arrow_rounded,
                        label: l10n.play,
                        onPressed: () => Navigator.pushNamed(context, '/game'),
                      ),
                      const SizedBox(height: 16),
                      MenuButton(
                        icon: Icons.leaderboard_rounded,
                        label: l10n.leaderboard,
                        onPressed: () => Navigator.pushNamed(context, '/leaderboard'),
                      ),
                      const SizedBox(height: 16),
                      MenuButton(
                        icon: Icons.settings_rounded,
                        label: l10n.settings,
                        onPressed: () => Navigator.pushNamed(context, '/settings'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 