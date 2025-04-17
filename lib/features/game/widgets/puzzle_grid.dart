import 'package:flutter/material.dart';

class PuzzleGrid extends StatelessWidget {
  final List<List<int>> puzzle;
  final Function(int, int) onTileTap;
  final List<bool> correctPositions;

  const PuzzleGrid({
    super.key,
    required this.puzzle,
    required this.onTileTap,
    required this.correctPositions,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: puzzle.length,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: puzzle.length * puzzle.length,
      itemBuilder: (context, index) {
        final row = index ~/ puzzle.length;
        final col = index % puzzle.length;
        final number = puzzle[row][col];
        final isCorrect = correctPositions[index];

        if (number == 0) {
          return const SizedBox.shrink();
        }

        return PuzzleTile(
          number: number,
          onTap: () => onTileTap(row, col),
          isCorrect: isCorrect,
        );
      },
    );
  }
}

class PuzzleTile extends StatefulWidget {
  final int number;
  final VoidCallback onTap;
  final bool isCorrect;

  const PuzzleTile({
    super.key,
    required this.number,
    required this.onTap,
    required this.isCorrect,
  });

  @override
  State<PuzzleTile> createState() => _PuzzleTileState();
}

class _PuzzleTileState extends State<PuzzleTile> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isCorrect) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(PuzzleTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCorrect && !oldWidget.isCorrect) {
      _controller.forward();
      _controller.repeat(reverse: true);
    } else if (!widget.isCorrect && oldWidget.isCorrect) {
      _controller.stop();
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isCorrect ? _scaleAnimation.value : 1.0,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: widget.isCorrect
                  ? [
                      BoxShadow(
                        color: Colors.green.withOpacity(_glowAnimation.value * 0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(8),
                child: Center(
                  child: Text(
                    widget.number.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: widget.isCorrect ? Colors.white : Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
} 