import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../models/game_state.dart';

class TutorialOverlay extends ConsumerWidget {
  const TutorialOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    
    return Stack(
      children: [
        // Arka plan karartma efekti
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        // Eğitim içeriği
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Başlık
                Text(
                  'Oyun İpuçları',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // İpuçları listesi
                _buildTutorialTips(context, gameState),
                const SizedBox(height: 20),
                // Kapatma butonu
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Anladım'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTutorialTips(BuildContext context, GameState gameState) {
    final tips = [
      _TutorialTip(
        icon: Icons.swap_horiz,
        title: 'Hamle Yapma',
        description: 'Boş kareye bitişik parçalara dokunarak hamle yapabilirsiniz.',
      ),
      _TutorialTip(
        icon: Icons.lightbulb_outline,
        title: 'İpuçları',
        description: 'Zorlandığınızda ipucu kullanabilirsiniz. Her zorluk seviyesinde farklı sayıda ipucu hakkınız var.',
      ),
      _TutorialTip(
        icon: Icons.bolt,
        title: 'Güç Özellikleri',
        description: 'Doğru hamleler yaparak güç puanı kazanın ve özel yeteneklerinizi kullanın.',
      ),
      _TutorialTip(
        icon: Icons.timer,
        title: 'Zaman Yönetimi',
        description: 'Zaman modunda her hamlede süreniz azalır. Hızlı ve doğru hamleler yapın.',
      ),
    ];

    return Column(
      children: tips.map((tip) => _buildTipItem(context, tip)).toList(),
    );
  }

  Widget _buildTipItem(BuildContext context, _TutorialTip tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            tip.icon,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tip.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TutorialTip {
  final IconData icon;
  final String title;
  final String description;

  const _TutorialTip({
    required this.icon,
    required this.title,
    required this.description,
  });
} 