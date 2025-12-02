import 'package:flutter/material.dart';

class AboutUsSection extends StatelessWidget {
  final AnimationController floatController;

  const AboutUsSection({super.key, required this.floatController});

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
                  'About Us',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                if (isMobile)
                  Column(
                    children: [
                      HoverScaleCard(
                        child: _cardContent(
                          title: 'Visi',
                          content:
                              'Menjadi pusat pembelajaran teknologi yang inovatif dan inspiratif bagi anak-anak, di mana mereka dapat mengembangkan keterampilan kreatif dan inovatif untuk menjadi pencipta teknologi masa depan.',
                          icon: Icons.track_changes,
                          iconColor: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 16),
                      HoverScaleCard(
                        child: _cardContent(
                          title: 'Misi',
                          content:
                              'Menyediakan pendidikan berkualitas melalui kurikulum komprehensif dalam ilustrasi, desain, robotik, dan programming, yang mendorong kreativitas, inovasi, serta kolaborasi antar anak-anak, sekaligus menyalurkan hobi dan minat mereka dalam teknologi, dan mengembangkan keterampilan yang relevan dengan kebutuhan industri masa depan.',
                          icon: Icons.rocket_launch,
                          iconColor: Colors.blueAccent,
                        ),
                      ),
                    ],
                  )
                else
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: HoverScaleCard(
                            child: _cardContent(
                              title: 'Visi',
                              content:
                                  'Menjadi pusat pembelajaran teknologi yang inovatif dan inspiratif bagi anak-anak, di mana mereka dapat mengembangkan keterampilan kreatif dan inovatif untuk menjadi pencipta teknologi masa depan.',
                              icon: Icons.track_changes,
                              iconColor: Colors.redAccent,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: HoverScaleCard(
                            child: _cardContent(
                              title: 'Misi',
                              content:
                                  'Menyediakan pendidikan berkualitas melalui kurikulum komprehensif dalam ilustrasi, desain, robotik, dan programming, yang mendorong kreativitas, inovasi, serta kolaborasi antar anak-anak, sekaligus menyalurkan hobi dan minat mereka dalam teknologi, dan mengembangkan keterampilan yang relevan dengan kebutuhan industri masa depan.',
                              icon: Icons.rocket_launch,
                              iconColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                FloatingMascot(
                  controller: floatController,
                  content: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      Image.asset(
                        'assets/Lia PNG 1.png',
                        width: 300,
                        height: 300,
                      ),
                      Image.asset(
                        'assets/Kod PNG 3.png',
                        width: 300,
                        height: 300,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardContent({
    required String title,
    required String content,
    required IconData icon,
    required Color iconColor,
  }) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: iconColor),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
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
