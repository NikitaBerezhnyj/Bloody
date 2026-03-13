import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class WidgetPromptScreen extends StatefulWidget {
  const WidgetPromptScreen({super.key});

  @override
  State<WidgetPromptScreen> createState() => _WidgetPromptScreenState();
}

class _WidgetPromptScreenState extends State<WidgetPromptScreen> {
  bool _showInstructions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _showInstructions
                ? _InstructionsView()
                : _PromoView(
                    onAddWidget: () => setState(() => _showInstructions = true),
                  ),
          ),
        ),
      ),
    );
  }
}

class _PromoView extends StatelessWidget {
  final VoidCallback onAddWidget;

  const _PromoView({required this.onAddWidget});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      children: [
        const Spacer(flex: 2),
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.3),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.opacity, color: Colors.white70, size: 28),
              const SizedBox(height: 8),
              const Text(
                '42',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                t.daysUntilNextDonation,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          t.widgetPromptTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          t.widgetPromptBody,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey, height: 1.5),
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onAddWidget,
            child: Text(t.widgetPromptAdd),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.notNow, style: const TextStyle(color: Colors.grey)),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _InstructionsView extends StatelessWidget {
  const _InstructionsView();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final steps = [
      (icon: Icons.touch_app_outlined, text: t.widgetStep1),
      (icon: Icons.widgets_outlined, text: t.widgetStep2),
      (icon: Icons.search, text: t.widgetStep3),
      (icon: Icons.open_with, text: t.widgetStep4),
    ];

    return Column(
      children: [
        const Spacer(),
        const Icon(Icons.widgets_outlined, color: Colors.red, size: 48),
        const SizedBox(height: 16),
        Text(
          t.widgetInstructionsTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        ...steps.indexed.map(((int, ({IconData icon, String text})) entry) {
          final (i, step) = entry;
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      step.text,
                      style: const TextStyle(fontSize: 15, height: 1.4),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(t.done),
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
