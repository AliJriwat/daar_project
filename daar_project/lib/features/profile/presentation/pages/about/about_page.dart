import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('about'.tr()),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/daar.png',
              height: 140,
            ),
            const SizedBox(height: 20),
            Text(
              'daar'.tr(),
              // textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'daar_about_text'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
