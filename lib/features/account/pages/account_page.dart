import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/features/common/bottom_nav_widget.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  int currentIndex = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/home');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.go('/notifications');
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: ListView(
        children: const [
          Divider(color: Color(0xFFE6E6E6),),
          AccountToLocation(
            imageLocation: Icons.add_box,
            titleLocation: 'My Orders',
            navigateIcon: Icons.arrow_forward_ios,
            goLocation: '/ordersPage',
          ),
          Divider(
            color: Color(0xFFE6E6E6),
            height: 8,
            thickness: 10,
          ),
          AccountToLocation(
            imageLocation: Icons.person_pin,
            titleLocation: 'My Details',
            navigateIcon: Icons.arrow_forward_ios,
            goLocation: '/myAccountPage',
          ),
          Divider(),
          AccountToLocation(
            imageLocation: Icons.home,
            titleLocation: 'Address Book',
            navigateIcon: Icons.arrow_forward_ios,
            goLocation: '/address',
          ),
          Divider(),
          AccountToLocation(
            imageLocation: Icons.credit_card,
            titleLocation: 'Payment Methods',
            navigateIcon: Icons.arrow_forward_ios,
            goLocation: '/cards',
          ),
          Divider(),
          AccountToLocation(
            imageLocation: Icons.notifications_outlined,
            titleLocation: 'Notifications',
            navigateIcon: Icons.arrow_forward_ios,
            goLocation: '/notifications',
          ),
          Divider(
            color: Color(0xFFE6E6E6),
            height: 8,
            thickness: 10,
          ),
          AccountToLocation(
            imageLocation: Icons.question_mark_outlined,
            titleLocation: 'FAQs',
            navigateIcon: Icons.arrow_forward_ios,
            goLocation: '/faq',
          ),
          Divider(),
          AccountToLocation(
            imageLocation: Icons.headphones,
            titleLocation: 'Help Center',
            navigateIcon: Icons.arrow_forward_ios,
            goLocation: '/help_center',
          ),
          Divider(
            color: Color(0xFFE6E6E6),
            thickness: 10,
            height: 8,
          ),
          AccountToLocation(
            imageLocation: Icons.logout_rounded,
            titleLocation: 'Log Out',
            iconColor: Colors.red,
            titleColor: Colors.red,
            goLocation: '/logout', 
          ),
        ]
      ),
      bottomNavigationBar: CustomBottomNav(currentIndex: 4),
    );
  }
}

class AccountToLocation extends StatelessWidget {
  final IconData imageLocation;
  final String titleLocation;
  final IconData? navigateIcon;
  final String goLocation;
  final Color? titleColor;
  final Color? iconColor;

  const AccountToLocation({
    super.key,
    required this.imageLocation,
    this.navigateIcon,
    this.titleColor,
    this.iconColor,
    required this.titleLocation,
    required this.goLocation,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        if (titleLocation == "Log Out") {
          _showLogoutDialog(context);
        } else {
          context.go(goLocation);
        }
      },
      leading: Icon(imageLocation, size: 28, color: iconColor),
      title: Text(
        titleLocation,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: titleColor ?? Colors.black,
        ),
      ),
      trailing: navigateIcon != null ? Icon(navigateIcon, size: 18) : null,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Log Out"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove("token");

                if (context.mounted) {
                  Navigator.pop(ctx);
                  context.go('/login');
                }
              },
              child: const Text("Log Out"),
            ),
          ],
        );
      },
    );
  }
}
