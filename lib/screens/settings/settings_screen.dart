import 'package:flutter/material.dart';
import 'package:merc_mania/screens/address/view/address_display/address_page.dart';
import 'package:merc_mania/screens/security/security.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class NavigationItem {
  final String title;
  final IconData? icon;
  final Widget route;

  NavigationItem({
    required this.title,
    this.icon,
    required this.route
  });
}

  
List<NavigationItem> navigationItem = [
  NavigationItem(
    title: 'Security',
    route: Security()
  ),
  NavigationItem(
    title: 'Address',
    route: AddressPage()
  ),
];

class _SettingsScreenState extends State<SettingsScreen> {
  late List<NavigationItem> results;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    results = [];
  }

  void filterItem(String query) {
    setState(() {
      results = navigationItem.where((item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
        SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                filterItem(controller.text);
                controller.openView();
              },
              leading: const Icon(Icons.search),
              );
          }, 
          suggestionsBuilder: (BuildContext context, SearchController controller) {  
            return List<ListTile>.generate(results.length, (int index) {
              return ListTile(
                title: Text(results[index].title),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => results[index].route)
                ),
              );
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ListTile(
              title: Text('Security')
            ),
            ListTile(
              title: Text('Address'),
            ),
            Text('Manage Finances', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ListTile(
              title: Text('Credit Card'),
            ),
            ListTile(
              title: Text('PayPal'),
            ),
            Text('Other Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ListTile(
              title: Text('Chat Settings'),
            ),
            ListTile(
              title: Text('Notification Settings'),
            ),
            ListTile(
              title: Text('Language'),
            ),
          ],),
        )
      ],
    );
  }
}