import 'package:flutter/material.dart';

class ProgramSection extends StatelessWidget {
  final AnimationController floatController;

  const ProgramSection({super.key, required this.floatController});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
        color: const Color(0xFFF9FAFB),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                const Text(
                  'Program',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                if (isMobile)
                  Column(
                    children: [
                      HoverScaleCard(
                        child: _programCardContent(
                          '🏠',
                          'Private Home Study',
                          'Belajar secara individual dan intensif dirumah kamu (1 murid 1 guru)',
                        ),
                      ),
                      const SizedBox(height: 16),
                      HoverScaleCard(
                        child: _programCardContent(
                          '💻',
                          'Online Class',
                          'Belajar secara online melalui daring dengan kelompok belajar (5-8 murid)',
                        ),
                      ),
                      const SizedBox(height: 16),
                      HoverScaleCard(
                        child: _programCardContent(
                          '🏫',
                          'School Partner',
                          'Menawarkan mitra dengan lembaga/sekolah/instansi untuk kegiatan belajar tambahan maupun persiapan kompetisi',
                        ),
                      ),
                    ],
                  )
                else
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: HoverScaleCard(
                            child: _programCardContent(
                              '🏠',
                              'Private Home Study',
                              'Belajar secara individual dan intensif dirumah kamu (1 murid 1 guru)',
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: HoverScaleCard(
                            child: _programCardContent(
                              '💻',
                              'Online Class',
                              'Belajar secara online melalui daring dengan kelompok belajar (5-8 murid)',
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: HoverScaleCard(
                            child: _programCardContent(
                              '🏫',
                              'School Partner',
                              'Menawarkan mitra dengan lembaga/sekolah/instansi untuk kegiatan belajar tambahan maupun persiapan kompetisi',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                FloatingMascot(
                  controller: floatController,
                  content: Image.asset(
                    'assets/Kod PNG 2.png',
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

  Widget _programCardContent(String icon, String title, String desc) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(desc, style: const TextStyle(fontSize: 14, height: 1.4)),
          ],
        ),
      ),
    );
  }
}

// Shared Widget
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
