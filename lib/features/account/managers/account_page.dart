import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
            goLocation: '/orders',
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
            goLocation: '/profile',
          ),
          Divider(),
          AccountToLocation(
            imageLocation: Icons.home,
            titleLocation: 'Address Book',
            navigateIcon: Icons.arrow_forward_ios,
            goLocation: '/settings',
          ),
          Divider(),
          AccountToLocation(
            imageLocation: Icons.credit_card,
            titleLocation: 'Payment Methods',
            navigateIcon: Icons.arrow_forward_ios,
            goLocation: '/help',
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
            goLocation: '/notifications',
          ),
          Divider(),
          AccountToLocation(
            imageLocation: Icons.headphones,
            titleLocation: 'Help Center',
            navigateIcon: Icons.arrow_forward_ios,
            goLocation: '/help',
          ),
          Divider(
            color: Color(0xFFE6E6E6),
            height: 8,
            thickness: 10,
          ),
          AccountToLocation(
            imageLocation: Icons.logout_rounded,
            titleLocation: 'Log Out',
            iconColor: Colors.red,
            titleColor: Colors.red,
            goLocation: '/help',
          ),
        ]
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       currentIndex = index;
      //     });
      //     switch (index) {
      //       case 0:
      //         context.go('/home');
      //         break;
      //       case 1:
      //         context.go('/searchPage');
      //         break;
      //       case 2:
      //         context.go('/savedProducts');
      //         break;
      //       case 3:
      //         context.go('/cart');
      //         break;
      //       case 4:
      //         context.go('/myAccount');
      //         break;
      //     }
      //   },
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.black,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.favorite_border), label: "Saved"),
      //     BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
      //   ],
      // ),
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
      onTap: () {
        context.go(goLocation);
      },
      leading: Icon(imageLocation, weight: 28,color: iconColor,),
      title: Text(
        titleLocation,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: titleColor),
      ),
      trailing: Icon(navigateIcon, size: 18),
    );
  }
}
