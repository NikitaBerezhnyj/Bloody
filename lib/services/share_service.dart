import 'dart:io';
import 'dart:ui' as ui;
import 'package:bloody/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/achievement/achievement_share_card.dart';
import '../l10n/app_localizations.dart';

class ShareService {
  static Future<void> shareAchievement({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
  }) async {
    final repaintBoundaryKey = GlobalKey();

    final widget = RepaintBoundary(
      key: repaintBoundaryKey,
      child: Theme(
        data: buildAppTheme(Brightness.light),
        child: Material(
          type: MaterialType.transparency,
          child: AchievementShareCard(
            icon: icon,
            title: title,
            description: description,
          ),
        ),
      ),
    );

    final shareText = AppLocalizations.of(context)!.shareAchievementText(title);
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (_) => Positioned(left: -10000, top: -10000, child: widget),
    );

    overlay.insert(overlayEntry);

    await Future.delayed(const Duration(milliseconds: 100));

    try {
      final boundary =
          repaintBoundaryKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}/achievement_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(pngBytes);

      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], text: shareText),
      );
    } finally {
      overlayEntry.remove();
    }
  }
}
