import 'package:flutter/material.dart';

class CoursesSection extends StatelessWidget {
  final AnimationController floatController;
  final GlobalKey sectionKey;

  const CoursesSection({
    super.key,
    required this.floatController,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        key: sectionKey,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
        color: Colors.white,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                const Text(
                  'Courses',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _courseCard(
                      '💻',
                      'Programming',
                      'Belajar coding dari dasar hingga mahir',
                    ),
                    _courseCard(
                      '🤖',
                      'Robotics/IoT',
                      'Eksplorasi dunia robotika dan IoT',
                    ),
                    _courseCard(
                      '🎨',
                      'Illustration',
                      'Kembangkan kreativitas visual',
                    ),
                    _courseCard(
                      '🖼️',
                      'Graphic Design',
                      'Segera hadir!',
                      isComingSoon: true,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                FloatingMascot(
                  controller: floatController,
                  content: Image.asset(
                    'assets/Lia PNG 3.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _courseCard(
    String? iconEmoji,
    String title,
    String desc, {
    bool isComingSoon = false,
    IconData? customIconData,
  }) {
    return HoverScaleCard(
      child: SizedBox(
        width: 180,
        height: 260,
        child: Stack(
          children: [
            Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (customIconData != null)
                      Icon(customIconData, size: 48, color: Colors.black87)
                    else
                      Text(
                        iconEmoji ?? '',
                        style: const TextStyle(fontSize: 48),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isComingSoon ? Colors.grey : null,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      desc,
                      style: TextStyle(
                        fontSize: 12,
                        color: isComingSoon ? Colors.grey : null,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            if (isComingSoon)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBBF24),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const Text(
                    'Coming Soon',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF78350F),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HoverScaleCard extends StatefulWidget {
  final Widget child;
  const HoverScaleCard({super.key, required this.child});
  @override
  State<HoverScaleCard> createState() => _HoverScaleCardState();
}

class _HoverScaleCardState extends State<HoverScaleCard> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}

class FloatingMascot extends StatelessWidget {
  final AnimationController controller;
  final Widget content;
  const FloatingMascot({
    super.key,
    required this.controller,
    required this.content,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -20 * controller.value),
          child: content,
        );
      },
    );
  }
}
