import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../models/game_state.dart';

class GameMascot extends ConsumerStatefulWidget {
  const GameMascot({super.key});

  @override
  ConsumerState<GameMascot> createState() => _GameMascotState();
}

class _GameMascotState extends ConsumerState<GameMascot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _bounceAnimation;
  late final Animation<double> _rotateAnimation;
  late final Animation<double> _scaleAnimation;
  
  GameState? _previousState;
  bool _isExcited = false;
  bool _isBored = false;
  bool _isCelebrating = false;
  int _consecutiveCorrectMoves = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rotateAnimation = Tween<double>(
      begin: -0.05,
      end: 0.05,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Sürekli animasyon
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleStateChange(GameState newState) {
    if (_previousState == null) {
      _previousState = newState;
      return;
    }

    // Hamle yapıldığında doğru pozisyondaki parça sayısını kontrol et
    if (newState.moveCount > _previousState!.moveCount) {
      final correctTilesNow = newState.correctPositions.expand((i) => i).where((e) => e).length;
      final correctTilesBefore = _previousState!.correctPositions.expand((i) => i).where((e) => e).length;
      
      if (correctTilesNow > correctTilesBefore) {
        _consecutiveCorrectMoves++;
        if (_consecutiveCorrectMoves >= 3) {
          _showExcitedAnimation();
        }
      } else {
        _consecutiveCorrectMoves = 0;
      }
    }

    // 15 saniye hamle yapılmadığında sıkılma
    if (newState.elapsedTime.inSeconds - _previousState!.elapsedTime.inSeconds > 15) {
      _showBoredAnimation();
    } else if (newState.moveCount > _previousState!.moveCount) {
      // Herhangi bir hamle yapıldığında sıkılma durumunu kaldır
      _isBored = false;
    }

    // Oyun tamamlandığında
    if (newState.isComplete && !_previousState!.isComplete) {
      _showCelebrationAnimation();
    }

    _previousState = newState;
  }

  void _showExcitedAnimation() {
    if (!_isCelebrating) { // Kutlama sırasında heyecan gösterme
      setState(() {
        _isExcited = true;
        _isBored = false;
      });
      
      // 3 saniye sonra normal duruma dön
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isExcited = false;
          });
          _consecutiveCorrectMoves = 0;
        }
      });
    }
  }

  void _showBoredAnimation() {
    if (!_isCelebrating && !_isExcited) { // Kutlama veya heyecan sırasında sıkılma gösterme
      setState(() {
        _isBored = true;
      });
    }
  }

  void _showCelebrationAnimation() {
    setState(() {
      _isCelebrating = true;
      _isExcited = false;
      _isBored = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);
    _handleStateChange(gameState);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Duruma göre animasyon büyüklüğünü ayarla
        double bounceValue = _bounceAnimation.value;
        double rotateValue = _rotateAnimation.value;
        double scaleValue = _scaleAnimation.value;

        if (_isCelebrating) {
          bounceValue *= 2; // Kutlamada daha yüksek zıplama
          rotateValue *= 2; // Daha fazla dönme
          scaleValue = 1.0 + (_scaleAnimation.value - 1.0) * 2; // Daha belirgin ölçekleme
        } else if (_isExcited) {
          bounceValue *= 1.5; // Heyecanda orta seviye zıplama
          rotateValue *= 1.5;
        } else if (_isBored) {
          bounceValue *= 0.5; // Sıkılınca daha az hareket
          rotateValue *= 0.3;
          scaleValue = 1.0 + (_scaleAnimation.value - 1.0) * 0.5;
        }

        return Transform.translate(
          offset: Offset(0, -bounceValue),
          child: Transform.rotate(
            angle: rotateValue,
            child: Transform.scale(
              scale: scaleValue,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: _getMascotImage(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getMascotImage() {
    if (_isCelebrating) {
      return Image.asset(
        'assets/images/mascot/mascot_celebrating.png',
        fit: BoxFit.contain,
      );
    } else if (_isExcited) {
      return Image.asset(
        'assets/images/mascot/mascot_excited.png',
        fit: BoxFit.contain,
      );
    } else if (_isBored) {
      return Image.asset(
        'assets/images/mascot/mascot_bored.png',
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        'assets/images/mascot/mascot_normal.png',
        fit: BoxFit.contain,
      );
    }
  }
} 