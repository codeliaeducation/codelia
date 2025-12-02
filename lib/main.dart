import 'package:flutter/material.dart';
import 'about_us.dart';
import 'courses.dart';
import 'program.dart';
import 'contact.dart';

void main() => runApp(const CodeliaApp());

class CodeliaApp extends StatelessWidget {
  const CodeliaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codelia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  final _aboutKey = GlobalKey();
  final _coursesKey = GlobalKey();
  final _programsKey = GlobalKey();
  final _contactKey = GlobalKey();

  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _scrollToSection(GlobalKey key) async {
    final context = key.currentContext;
    if (context == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final renderBox = context.findRenderObject() as RenderBox;
        final positionOnScreen = renderBox.localToGlobal(Offset.zero).dy;
        final currentScrollOffset = _scrollController.offset;
        final targetOffset = currentScrollOffset + positionOnScreen - 60 - 10;

        final clampedOffset = targetOffset.clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        );

        await _scrollController.animateTo(
          clampedOffset,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      } catch (e) {
        debugPrint("Error scrolling: $e");
      }
    });
  }

  void _showMobileMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.info_outline,
                  color: Colors.blueAccent,
                ),
                title: const Text(
                  'About Us',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _scrollToSection(_aboutKey);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.school_outlined,
                  color: Colors.orange,
                ),
                title: const Text(
                  'Courses',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _scrollToSection(_coursesKey);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.category_outlined,
                  color: Colors.purple,
                ),
                title: const Text(
                  'Program',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _scrollToSection(_programsKey);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.contact_mail_outlined,
                  color: Colors.green,
                ),
                title: const Text(
                  'Contact',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _scrollToSection(_contactKey);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 4,
            toolbarHeight: 60,
            title: Row(
              children: [
                Image.asset('assets/logo.png', width: 70, height: 70),
                const SizedBox(width: 8),
              ],
            ),
            actions: isMobile
                ? [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black87),
                      onPressed: _showMobileMenu,
                    ),
                  ]
                : [
                    TextButton(
                      onPressed: () => _scrollToSection(_aboutKey),
                      child: const Text(
                        'About Us',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _scrollToSection(_coursesKey),
                      child: const Text(
                        'Courses',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _scrollToSection(_programsKey),
                      child: const Text(
                        'Program',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _scrollToSection(_contactKey),
                      child: const Text(
                        'Contact',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
          ),

          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/Student Codelia.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Codelia',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 4.0,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Pusat Pembelajaran Teknologi untuk Generasi Masa Depan',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 2.0,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          AboutUsSection(
            sectionKey: _aboutKey,
            floatController: _floatController,
          ),

          CoursesSection(
            sectionKey: _coursesKey,
            floatController: _floatController,
          ),

          ProgramSection(
            sectionKey: _programsKey,
            floatController: _floatController,
          ),

          ContactSection(
            sectionKey: _contactKey,
            floatController: _floatController,
          ),

          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              color: const Color(0xFF1f2937),
              child: const Center(
                child: Text(
                  '© 2026 Codelia. All rights reserved.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
