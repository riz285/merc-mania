import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/consts.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  Future<void> makePhoneCall(String phoneNum) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNum
    );
    if (!await launchUrl(launchUri)) {
      throw 'Could not launch $launchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('Help Center'),
      ),
      body: ListView(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            children: [
              Column(children: [
                Text('Top Enquiries', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ListTile(title: Text('How do I report an unauthorized transaction or account activity?'),
                  onTap: () {},),
                ListTile(title: Text('How do I spot a fake, fraudulent, or phishing seller?'),
                  onTap: () {},)
              ]),
              Divider(),
              Column(children: [
                Text('Frequently Asked', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ListTile(title: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
                  onTap: () {},),
                ListTile(title: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
                  onTap: () {},),
                ListTile(title: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
                  onTap: () {},),
                ListTile(title: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
                  onTap: () {},),
                ListTile(title: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
                  onTap: () {},)
              ]),
              Divider(),
              Column(children: [
                Text('Contact Us', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Card(
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    leading: Icon(FontAwesomeIcons.solidMessage, size: 20),
                    title: Text('Chat with us'),
                    // Message bot
                    onTap: () {},
                  )
                ),
                Card(
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    leading: Icon(FontAwesomeIcons.phone, size: 20),
                    title: Text('Call us'),
                    subtitle: Text('If you are hearing or speech impaired, please contact us via IP relay service.'),
                    onTap: () {
                      makePhoneCall(appPhoneNumber);
                    },  
                  )),
              ],),
            ],
          ),
    );
  }
}