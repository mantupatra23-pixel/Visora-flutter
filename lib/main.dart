// lib/main.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const VisoraApp());
}

class VisoraApp extends StatelessWidget {
  const VisoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visora AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate loading then go to onboarding/login
    Timer(const Duration(milliseconds: 1700), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const WelcomeScreen(),
          transitionsBuilder: (_, anim, __, child) {
            return FadeTransition(opacity: anim, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: primary.withOpacity(0.06),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // If you added Lottie asset: assets/lottie/loading.json
            SizedBox(
              height: 170,
              width: 170,
              child: Lottie.asset(
                'assets/lottie/loading.json',
                repeat: true,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Visora AI',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.deepPurple.shade700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Ultimate AI Video Studio',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final purple = Colors.deepPurple;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top row: Logo + title
              Row(
                children: [
                  Image.asset(
                    'assets/logo/visora_logo.png',
                    height: 56,
                    width: 56,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Visora AI',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: purple.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Hero card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: purple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Create videos automatically from scripts — AI voice, scenes, and edits. Fast export for Shorts & Reels.',
                        style: GoogleFonts.inter(fontSize: 15),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Image.asset(
                      'assets/logo/visora_logo_splash.png',
                      height: 56,
                      width: 56,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              // Buttons
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AuthScreen()),
                  );
                },
                icon: const Icon(Icons.play_circle, size: 20),
                label: Text('Get Started', style: GoogleFonts.inter(fontSize: 16)),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
                child: Text('Skip & Explore', style: GoogleFonts.inter()),
              ),
              const Spacer(),
              // Footer quick features
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _FeatureChip(icon: Icons.flash_on, label: 'Fast Export'),
                  _FeatureChip(icon: Icons.subtitles, label: 'Auto Captions'),
                  _FeatureChip(icon: Icons.hd, label: 'HD Renders'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeatureChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(backgroundColor: Colors.deepPurple.shade50, child: Icon(icon, color: Colors.deepPurple)),
        const SizedBox(height: 6),
        Text(label, style: GoogleFonts.inter(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _email = TextEditingController();
  final _name = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _name.dispose();
    super.dispose();
  }

  void _continue() {
    // For now a simple nav to Home
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in', style: GoogleFonts.inter()),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Your name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _email,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _continue,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text('Continue', style: GoogleFonts.inter(fontSize: 16)),
          ),
        ]),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _sampleThumbs = [
    'https://picsum.photos/seed/visora1/600/360',
    'https://picsum.photos/seed/visora2/600/360',
    'https://picsum.photos/seed/visora3/600/360',
  ];

  void _onShareApp() {
    Share.share('Check Visora AI - create videos automatically!'); // share_plus
  }

  @override
  Widget build(BuildContext context) {
    final purple = Colors.deepPurple;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: Row(children: [
          Image.asset('assets/logo/visora_logo_white.png', height: 34),
          const SizedBox(width: 10),
          Text('Visora AI', style: GoogleFonts.inter(fontSize: 18)),
        ]),
        actions: [
          IconButton(onPressed: _onShareApp, icon: const Icon(Icons.share)),
          const SizedBox(width: 6),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          Center(child: Text('Projects', style: GoogleFonts.inter(fontSize: 18))),
          Center(child: Text('Profile', style: GoogleFonts.inter(fontSize: 18))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Open create new video flow
          showModalBottomSheet(
            context: context,
            builder: (c) => Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('Create New Video', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Text('Paste your script and choose style. (Demo)', style: GoogleFonts.inter()),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(backgroundColor: purple),
                  child: const Text('Start'),
                ),
              ]),
            ),
          );
        },
        backgroundColor: purple,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: purple,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 600));
        setState(() {});
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        children: [
          Text('Recommended', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _sampleThumbs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) => _VideoCard(
                title: 'Auto Script #${i + 1}',
                imageUrl: _sampleThumbs[i],
                onTap: () {},
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text('Recent Projects', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          for (int i = 0; i < 3; i++)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: _sampleThumbs[i],
                  width: 110,
                  height: 64,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: Colors.grey.shade200),
                  errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
                ),
              ),
              title: Text('Project ${i + 1}', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              subtitle: Text('Duration 00:30 • HD', style: GoogleFonts.inter()),
              trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ),
        ],
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  const _VideoCard({required this.title, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 260,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.play_arrow, color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
