import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/screens/help_center/help_center.dart';

import '../../core/configs/themes/app_colors.dart';

class Policy extends StatelessWidget {
  const Policy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('Policies and Agreements'),
      ),
      body: ListView(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        children: [
          Align(child: Text('ACCEPTABLE USE POLICY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          Text('Last updated on November 22, 2024'),
          SizedBox(height: 16),
          Text('You are independently responsible for complying with all applicable laws in all of your actions related to your use of our services, regardless of the purpose of the use. In addition, you must adhere to the terms of this Acceptable Use Policy. Violation of this Acceptable Use Policy constitutes a violation of the PayPal User Agreement.', 
            textAlign: TextAlign.justify),
          SizedBox(height: 16),
          Text('Prohibited Activities', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('You may not use the PayPal service for activities that:'),
          SizedBox(height: 16),
          Padding(padding: EdgeInsets.only(left: 8),
            child:
              Text('''1. violate any law, statute, ordinance or regulation.

                      2. relate to transactions involving (a) narcotics, steroids, certain controlled substances or other products that present a risk to consumer safety, (b) drug paraphernalia, (c) cigarettes, (d) items that encourage, promote, facilitate or instruct others to engage in illegal activity, (e) stolen goods including digital and virtual goods, (f) the promotion of hate, violence, racial or other forms of intolerance that is discriminatory or the financial exploitation of a crime, (g) items that are considered obscene, (h) items that infringe or violate any copyright, trademark, right of publicity or privacy or any other proprietary right under the laws of any jurisdiction, (i) certain sexually oriented materials or services, (j) ammunition, firearms, or certain firearm parts or accessories, or (k) certain weapons or knives regulated under applicable law.
                      
                      3. relate to transactions that (a) show the personal information of third parties in violation of applicable law, (b) support pyramid or ponzi schemes, matrix programs, other "get rich quick" schemes or certain multi-level marketing programs, (c) are associated with purchases of annuities or lottery contracts, lay-away systems, off-shore banking or transactions to finance or refinance debts funded by a credit card, (d) are for the sale of certain items before the seller has control or possession of the item, (e) are by payment processors to collect payments on behalf of merchants, (f) are associated with the sale of traveler's checks or money orders, (g)involve currency exchanges or check cashing businesses, (h) involve certain credit repair, debt settlement services, credit transactions or insurance activities, or (i) involve offering or receiving payments for the purpose of bribery or corruption.
                  ''',
                  textAlign: TextAlign.justify)
          ),
          SizedBox(height: 16),
          Text('More Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          LinkableText(text: 'To lean more about the Acceptable Use Policy, please refer to our Help Center', linkText: 'Help Center', link: HelpCenter()),
          SizedBox(height: 16),
          Text('Violations of the Acceptable Use Policy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          LinkableText(text: 'We encourage you to report violations of this Acceptable Use Policy to PayPal immediately. If you have a question about whether a type of transaction may violate the Acceptable Use Policy, or wish to file a report, you can do so here', linkText: 'here', link: Container())
      ])
    );
  }
}

class LinkableText extends StatelessWidget {
  final String text;
  final String linkText;
  final Widget link;
  const LinkableText({super.key, required this.text, required this.linkText, required this.link});

  @override
  Widget build(BuildContext context) {
    final linkSpan = TextSpan(
      text: linkText,
      style: TextStyle(color: AppColors.tab),
      recognizer: TapGestureRecognizer()..onTap = () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => link))
    );
    final textSpan = TextSpan(text: text.replaceAll(linkText, ''));
    final combinedTextSpan = TextSpan(children: [textSpan, linkSpan]);
    return RichText(text: combinedTextSpan);
  }
}