import 'package:flutter/material.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  final String termsText = '''
  Welcome to MeroKaam! These Terms and Conditions ("Terms") govern your use of the MeroKaam platform ("Software" or "Service"). By accessing or using MeroKaam, you agree to these Terms. If you do not agree to any part of the Terms, you should discontinue use of the Service.

  1. General Use
  MeroKaam is an employment matchmaking platform that helps users connect with job opportunities. Using our software, you agree to comply with all applicable local, national, and international laws and regulations.

  2. User Accounts
  You are responsible for maintaining the confidentiality of your account information and all activities under your account. You agree to notify us immediately of any unauthorized use of your account or any other security breach.

  3. Compliance with Data Protection Laws
  MeroKaam complies with data protection regulations, including the General Data Protection Regulation (GDPR) for users within the European Union and local Nepalese data protection laws. We are committed to protecting your privacy and maintaining transparency in handling your data.

  3.1. Data Protection Officer (DPO)
  We have appointed a Data Protection Officer (DPO) to oversee all data protection-related matters. If you have any questions or concerns about your privacy or our compliance, the DPO can be contacted at [insert contact email].

  3.2. Data Minimization
  We follow a data minimization policy, meaning we only collect the minimal amount of personal data necessary for employment matchmaking and providing our service. Personal data collected includes [list the types of data collected], which is essential for improving job recommendations.

  3.3. User Consent
  Your explicit consent is required before we collect and process your data. By registering on MeroKaam and agreeing to these Terms, you consent to collecting and using your personal data as outlined in our Privacy Policy. You may withdraw your consent at any time by contacting us or through the user account settings, which will limit our ability to provide certain services.

  4. Data Security
  We take appropriate technical and organizational measures to protect your data from unauthorized access, use, or disclosure. However, no data transmission over the Internet is entirely secure, and you agree to use the Service at your own risk.

  5. User Responsibilities
  Prohibited Activities: You agree not to use MeroKaam for any unlawful or prohibited purposes, including distributing illegal content, hacking, or infringing on the intellectual property rights of others.
  - Accuracy of Information: You are responsible for ensuring that the information you provide is accurate, current, and complete.

  6. Limitation of Liability
  MeroKaam provides its services "as is" without warranties of any kind, either express or implied. We are not responsible for any losses or damages arising from your use of the platform, including, but not limited to, data loss, financial losses, or reputational harm.

  7. Termination
  MeroKaam reserves the right to suspend or terminate your account at our discretion if you breach these Terms or engage in any unlawful or prohibited activities.

  8. Changes to Terms
  We may update these Terms occasionally to reflect changes in our services or legal requirements. We will notify users through the platform or via email if we make changes. Continued use of the Service after changes indicates acceptance of the revised Terms.

  9. Compliance with Laws
  When using MeroKaam, you agree to comply with all applicable laws, including data protection laws in your jurisdiction. Our Privacy Policy details how we comply with local and international data protection regulations.

  10. Governing Law
  These Terms will be governed by and construed in accordance with the laws of Nepal, without regard to its conflict of law provisions.

  11. Contact Information
  If you have any questions about these Terms or would like to contact the Data Protection Officer regarding privacy concerns, please email us at [insert contact email].
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and Conditions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  termsText,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle decline action
                    Navigator.pop(context, false); // Pass result back if needed
                  },
                  child: Text("Decline"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle accept action
                    Navigator.pop(context, true); // Pass result back if needed
                  },
                  child: Text("Accept"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TermsAndConditionsWidget(),
  ));
}
