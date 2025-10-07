import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/features/common/bottom_nav_widget.dart';

import '../widgets/help_widgets.dart';

class HelpCenterPage extends StatelessWidget {
  HelpCenterPage({super.key});

  final List<Map<String, dynamic>> helpItems = [
    {"icon": Icons.headphones, "title": "Customer Service"},
    {"customIcon": SvgPicture.asset('assets/icons/Whatsapp.svg'), "title": "Whatsapp"},
    {"customIcon": SvgPicture.asset('assets/icons/Web.svg'), "title": "Website"},
    {"icon": Icons.facebook, "title": "Facebook"},
    {"customIcon": SvgPicture.asset('assets/icons/Twitter.svg'), "title": "Twitter"},
    {"customIcon": SvgPicture.asset('assets/icons/instagram.svg'), "title": "Instagram"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/myAccountPage'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Help Center',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.go('/notifications'),
            icon: const Icon(Icons.notification_add_outlined),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: helpItems.length,
        itemBuilder: (context, index) {
          final item = helpItems[index];
          return HelpCenterButton(
            icon: item["icon"],
            title: item["title"],
            customIcon: item["customIcon"],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 4),
    );
  }
}
