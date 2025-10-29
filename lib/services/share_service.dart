import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/achievement_share_card.dart';
import '../l10n/app_localizations.dart';

class ShareService {
  static Future<void> shareAchievement({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) async {
    final repaintBoundaryKey = GlobalKey();
    const size = Size(800, 800);

    final widget = RepaintBoundary(
      key: repaintBoundaryKey,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: size.width,
          height: size.height,
          color: color,
          child: AchievementShareCard(
            icon: icon,
            title: title,
            description: description,
            color: color,
          ),
        ),
      ),
    );

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        left: -10000,
        top: -10000,
        child: widget,
      ),
    );

    overlay.insert(overlayEntry);

    await Future.delayed(const Duration(milliseconds: 100));

    try {
      final boundary = repaintBoundaryKey.currentContext!.findRenderObject()
      as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = File(
          '${tempDir.path}/achievement_${DateTime.now().millisecondsSinceEpoch}.png'
      );
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: AppLocalizations.of(context)!.shareAchievementText(title),
      );
    } finally {
      overlayEntry.remove();
    }
  }
}