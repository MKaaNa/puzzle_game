/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/background.json
  String get background => 'assets/animations/background.json';

  /// File path: assets/animations/mascot.json
  String get mascot => 'assets/animations/mascot.json';

  /// List of all assets
  List<String> get values => [background, mascot];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/mascot
  $AssetsImagesMascotGen get mascot => const $AssetsImagesMascotGen();
}

class $AssetsSoundsGen {
  const $AssetsSoundsGen();

  /// File path: assets/sounds/tile_move.mp3
  String get tileMove => 'assets/sounds/tile_move.mp3';

  /// List of all assets
  List<String> get values => [tileMove];
}

class $AssetsImagesMascotGen {
  const $AssetsImagesMascotGen();

  /// File path: assets/images/mascot/mascot.png
  AssetGenImage get mascot =>
      const AssetGenImage('assets/images/mascot/mascot.png');

  /// File path: assets/images/mascot/mascot_bored.png
  AssetGenImage get mascotBored =>
      const AssetGenImage('assets/images/mascot/mascot_bored.png');

  /// File path: assets/images/mascot/mascot_celebrating.png
  AssetGenImage get mascotCelebrating =>
      const AssetGenImage('assets/images/mascot/mascot_celebrating.png');

  /// File path: assets/images/mascot/mascot_excited.png
  AssetGenImage get mascotExcited =>
      const AssetGenImage('assets/images/mascot/mascot_excited.png');

  /// File path: assets/images/mascot/mascot_hint.png
  AssetGenImage get mascotHint =>
      const AssetGenImage('assets/images/mascot/mascot_hint.png');

  /// File path: assets/images/mascot/mascot_normal.png
  AssetGenImage get mascotNormal =>
      const AssetGenImage('assets/images/mascot/mascot_normal.png');

  /// File path: assets/images/mascot/mascot_return.png
  AssetGenImage get mascotReturn =>
      const AssetGenImage('assets/images/mascot/mascot_return.png');

  /// File path: assets/images/mascot/mascott.png
  AssetGenImage get mascott =>
      const AssetGenImage('assets/images/mascot/mascott.png');

  /// File path: assets/images/mascot/maskotit.png
  AssetGenImage get maskotit =>
      const AssetGenImage('assets/images/mascot/maskotit.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        mascot,
        mascotBored,
        mascotCelebrating,
        mascotExcited,
        mascotHint,
        mascotNormal,
        mascotReturn,
        mascott,
        maskotit
      ];
}

class Assets {
  const Assets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSoundsGen sounds = $AssetsSoundsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
