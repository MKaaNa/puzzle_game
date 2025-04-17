import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/settings_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../features/game/models/game_state.dart';
import '../../../features/game/models/game_difficulty.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Ses ve Titreşim Ayarları
          Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Ses ve Titreşim',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SwitchListTile(
                  title: const Text('Ses Efektleri'),
                  subtitle: const Text('Oyun seslerini aç/kapat'),
                  value: settings.isSoundEnabled,
                  onChanged: (value) => ref.read(settingsProvider.notifier).toggleSound(),
                ),
                SwitchListTile(
                  title: const Text('Titreşim'),
                  subtitle: const Text('Oyun titreşimlerini aç/kapat'),
                  value: settings.isVibrationEnabled,
                  onChanged: (value) => ref.read(settingsProvider.notifier).toggleVibration(),
                ),
              ],
            ),
          ),

          // Oyun Tercihleri
          Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Oyun Tercihleri',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                ListTile(
                  title: const Text('Varsayılan Zorluk'),
                  subtitle: Text(settings.defaultDifficulty.label),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showDifficultyPicker(context, ref),
                ),
                ListTile(
                  title: const Text('Varsayılan Oyun Modu'),
                  subtitle: Text(_getGameModeLabel(settings.defaultGameMode)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showGameModePicker(context, ref),
                ),
              ],
            ),
          ),

          // Görünüm Ayarları
          Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Görünüm',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SwitchListTile(
                  title: const Text('Karanlık Mod'),
                  subtitle: const Text('Uygulama temasını değiştir'),
                  value: settings.isDarkMode,
                  onChanged: (value) => ref.read(settingsProvider.notifier).toggleDarkMode(),
                ),
                ListTile(
                  title: const Text('Dil'),
                  subtitle: Text(settings.language == 'en' ? 'English' : 'Türkçe'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showLanguagePicker(context, ref),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getGameModeLabel(GameMode mode) {
    switch (mode) {
      case GameMode.classic:
        return 'Klasik Mod';
      case GameMode.timeTrial:
        return 'Zamana Karşı';
      case GameMode.limitedMoves:
        return 'Sınırlı Hamle';
      case GameMode.zen:
        return 'Zen Modu';
    }
  }

  Future<void> _showDifficultyPicker(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<GameDifficulty>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Zorluk Seçin'),
        children: GameDifficulty.values.map((difficulty) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, difficulty),
            child: Text(difficulty.label),
          );
        }).toList(),
      ),
    );

    if (result != null) {
      ref.read(settingsProvider.notifier).setDefaultDifficulty(result);
    }
  }

  Future<void> _showGameModePicker(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<GameMode>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Oyun Modu Seçin'),
        children: GameMode.values.map((mode) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, mode),
            child: Text(_getGameModeLabel(mode)),
          );
        }).toList(),
      ),
    );

    if (result != null) {
      ref.read(settingsProvider.notifier).setDefaultGameMode(result);
    }
  }

  Future<void> _showLanguagePicker(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Dil Seçin'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'en'),
            child: const Text('English'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'tr'),
            child: const Text('Türkçe'),
          ),
        ],
      ),
    );

    if (result != null) {
      ref.read(settingsProvider.notifier).setLanguage(result);
    }
  }
} 