import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class PuzzleGrid extends StatefulWidget {
  const PuzzleGrid({super.key});

  @override
  State<PuzzleGrid> createState() => _PuzzleGridState();
}

class _PuzzleGridState extends State<PuzzleGrid> {
  final Map<int, GlobalKey<_PuzzleTileState>> _tileKeys = {};
  int? _lastHintedTile;

  void _showHint(BuildContext context, GameProvider gameProvider) {
    final hint = gameProvider.getHint();
    if (hint != null) {
      // Önceki ipucu animasyonunu durdur
      if (_lastHintedTile != null && _tileKeys[_lastHintedTile]?.currentState != null) {
        _tileKeys[_lastHintedTile]!.currentState!.stopHintAnimation();
      }

      // Yeni ipucu animasyonunu başlat
      final tileKey = _tileKeys[hint['tileIndex']];
      if (tileKey?.currentState != null) {
        _lastHintedTile = hint['tileIndex'];
        tileKey!.currentState!.showHintAnimation(hint['direction']);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                'Hint: ${hint['direction']} tile ${hint['number']}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final size = gameProvider.difficulty.gridSize;
    final grid = gameProvider.grid;

    if (grid.isEmpty) {
      return const Center(
        child: Text(
          'Press "New Game" to start',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Column(
      children: [
        if (gameProvider.status == GameStatus.inProgress)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton.icon(
              onPressed: () => _showHint(context, gameProvider),
              icon: const Icon(Icons.lightbulb_outline),
              label: const Text('Get Hint'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: size * size,
                  itemBuilder: (context, index) {
                    final row = index ~/ size;
                    final col = index % size;
                    final number = grid[row][col];

                    // Empty tile
                    if (number == 0) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    }

                    // Her taş için bir key oluştur
                    _tileKeys[index] = _tileKeys[index] ?? GlobalKey<_PuzzleTileState>();

                    return PuzzleTile(
                      key: _tileKeys[index],
                      number: number,
                      index: index,
                      canMove: gameProvider.canMoveTile(index),
                      onTap: () {
                        // Taş hareket ettirildiğinde ipucu animasyonunu durdur
                        if (_lastHintedTile != null && _tileKeys[_lastHintedTile]?.currentState != null) {
                          _tileKeys[_lastHintedTile]!.currentState!.stopHintAnimation();
                          _lastHintedTile = null;
                        }
                        gameProvider.moveTile(index);
                      },
                      isCorrectPosition: gameProvider.isTileCorrectPosition(index),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PuzzleTile extends StatefulWidget {
  final int number;
  final int index;
  final bool canMove;
  final VoidCallback onTap;
  final bool isCorrectPosition;

  const PuzzleTile({
    super.key,
    required this.number,
    required this.index,
    required this.canMove,
    required this.onTap,
    required this.isCorrectPosition,
  });

  @override
  State<PuzzleTile> createState() => _PuzzleTileState();
}

class _PuzzleTileState extends State<PuzzleTile> with SingleTickerProviderStateMixin {
  late AnimationController _hintAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool _isShowingHint = false;
  String? _hintDirection;

  @override
  void initState() {
    super.initState();
    _hintAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _hintAnimationController,
      curve: Curves.easeInOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _hintAnimationController,
      curve: Curves.easeInOut,
    ));

    _hintAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _hintAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed && _isShowingHint) {
        _hintAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _hintAnimationController.dispose();
    super.dispose();
  }

  void showHintAnimation(String direction) {
    setState(() {
      _isShowingHint = true;
      _hintDirection = direction;
    });
    _hintAnimationController.forward();
  }

  void stopHintAnimation() {
    setState(() {
      _isShowingHint = false;
      _hintDirection = null;
    });
    _hintAnimationController.stop();
    _hintAnimationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.canMove ? widget.onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedBuilder(
          animation: _hintAnimationController,
          builder: (context, child) {
            return Stack(
              children: [
                if (_isShowingHint)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(_glowAnimation.value * 0.5),
                          blurRadius: 12,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                  ),
                Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          widget.isCorrectPosition
                              ? Colors.green
                              : Theme.of(context).colorScheme.primary,
                          widget.isCorrectPosition
                              ? Colors.green.shade600
                              : Theme.of(context).colorScheme.primary.withBlue(
                                    Theme.of(context).colorScheme.primary.blue + 20,
                                  ),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        if (widget.canMove || widget.isCorrectPosition)
                          BoxShadow(
                            color: (widget.isCorrectPosition ? Colors.green : Theme.of(context).colorScheme.primary)
                                .withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        if (widget.isCorrectPosition)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        Center(
                          child: Text(
                            widget.number.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (_isShowingHint && _hintDirection != null)
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                _hintDirection == 'Move Up'
                                    ? Icons.arrow_upward
                                    : _hintDirection == 'Move Down'
                                        ? Icons.arrow_downward
                                        : _hintDirection == 'Move Left'
                                            ? Icons.arrow_back
                                            : Icons.arrow_forward,
                                color: Colors.white,
                                size: 32 * _glowAnimation.value,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

