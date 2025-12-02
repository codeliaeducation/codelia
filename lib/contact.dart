import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  final AnimationController floatController;
  final GlobalKey sectionKey;

  const ContactSection({
    super.key,
    required this.floatController,
    required this.sectionKey,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Tidak bisa membuka: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

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
                  'Contact',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                if (isMobile)
                  Column(
                    children: [
                      HoverScaleCard(
                        child: _contactCard(
                          icon: '📧',
                          title: 'Email',
                          content: 'codelia.edu@gmail.com',
                          onTap: () =>
                              _launchUrl('mailto:codelia.edu@gmail.com'),
                          isLink: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      HoverScaleCard(
                        child: _contactCard(
                          icon: '💬',
                          title: 'WhatsApp',
                          content: 'Chat Admin',
                          onTap: () =>
                              _launchUrl('https://wa.me/6285117781062'),
                          isButton: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      HoverScaleCard(
                        child: _contactCard(
                          icon: '📱',
                          title: 'Social Media',
                          content: '@codelia.education',
                          subContent: 'IG / FB / TikTok / YT',
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
                            child: _contactCard(
                              icon: '📧',
                              title: 'Email',
                              content: 'codelia.edu@gmail.com',
                              onTap: () =>
                                  _launchUrl('mailto:codelia.edu@gmail.com'),
                              isLink: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: HoverScaleCard(
                            child: _contactCard(
                              icon: '💬',
                              title: 'WhatsApp',
                              content: 'Chat Admin',
                              onTap: () =>
                                  _launchUrl('https://wa.me/6285117781062'),
                              isButton: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: HoverScaleCard(
                            child: _contactCard(
                              icon: '📱',
                              title: 'Social Media',
                              content: '@codelia.education',
                              subContent: 'IG / FB / TikTok / YT',
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
                    'assets/Kod PNG 1.png',
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

  Widget _contactCard({
    required String icon,
    required String title,
    required String content,
    String? subContent,
    VoidCallback? onTap,
    bool isButton = false,
    bool isLink = false,
  }) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 50)),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (isButton) ...[
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF667eea),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Text(content),
              ),
            ] else if (isLink && onTap != null)
              InkWell(
                onTap: onTap,
                child: Text(
                  content,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            else
              Text(
                content,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            if (subContent != null) ...[
              const SizedBox(height: 8),
              Text(
                subContent,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
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
