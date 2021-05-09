import 'package:flutter/material.dart';
import 'package:mobile_factory/pages/address/address_page.dart';
import 'package:mobile_factory/pages/auth/authentication_service.dart';
import 'package:mobile_factory/pages/favorite/favorite_page.dart';
import 'package:mobile_factory/pages/home/home_page.dart';
import 'package:mobile_factory/pages/order/oders_page.dart';
import 'package:mobile_factory/pages/profile/profile_page.dart';
import 'package:mobile_factory/providers/user_provider.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20.0);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Text(
              "Hello, ${user.firstName}",
              style: TextStyle(fontSize: 25.0),
            ),
          ),
          Expanded(
            child: ListView(
              padding: padding,
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                buildMenuItem(
                  context: context,
                  text: 'Home',
                  icon: Icons.home_outlined,
                  onClick: () => selectedItem(context, 0),
                ),
                buildMenuItem(
                  context: context,
                  text: 'Favorite',
                  icon: Icons.favorite_outline,
                  onClick: () => selectedItem(context, 1),
                ),
                buildMenuItem(
                  context: context,
                  text: 'Orders',
                  icon: Icons.shopping_bag_outlined,
                  onClick: () => selectedItem(context, 2),
                ),
                buildMenuItem(
                  context: context,
                  text: 'Address',
                  icon: Icons.house_outlined,
                  onClick: () => selectedItem(context, 3),
                ),
                buildMenuItem(
                  context: context,
                  text: 'Profile',
                  icon: Icons.person_outline,
                  onClick: () => selectedItem(context, 4),
                ),
                buildMenuItem(
                  context: context,
                  text: 'Sign out',
                  icon: Icons.logout,
                  onClick: () => selectedItem(context, 5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    @required BuildContext context,
    @required String text,
    @required IconData icon,
    @required Function onClick,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26.0,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
      onTap: onClick,
    );
  }

  Future<void> selectedItem(BuildContext context, int index) async {
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(pageBuilder: (_, __, ___) => HomePage()),
          (Route<dynamic> route) => false,
        );
        break;
      case 1:
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => FavoritePage(),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => OrdersPage(),
          ),
        );
        break;
      case 3:
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => AddressPage(),
          ),
        );
        break;
      case 4:
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProfilePage(),
          ),
        );
        break;
      case 5:
        await context.read<AuthenticationService>().signOut();
        break;
    }
  }
}
