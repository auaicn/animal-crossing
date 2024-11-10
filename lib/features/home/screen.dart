import 'package:animal_crossing/common/d_icon.dart';
import 'package:animal_crossing/common/d_text.dart';
import 'package:animal_crossing/features/home/icons/icons_section.dart';
import 'package:animal_crossing/features/home/pricing/pricing_section.dart';
import 'package:flutter/material.dart';

class Screen$Home extends StatefulWidget {
  const Screen$Home({super.key});

  @override
  State<Screen$Home> createState() => _Screen$HomeState();
}

class _Screen$HomeState extends State<Screen$Home> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DIcon(
              iconName: DIcon$Name.timmyNook,
              size: 32,
            ),
            SizedBox(
              width: 10,
            ),
            DText(
              text: 'Animal Crossing',
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: selectedTabIndex == 0 ? IconsSection() : PricingSection(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => selectedTabIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: DIcon(iconName: DIcon$Name.kkSlider),
            label: 'Icons',
          ),
          BottomNavigationBarItem(
            icon: DIcon(iconName: DIcon$Name.moneyBag),
            label: 'Pricing',
          ),
        ],
      ),
    );
  }
}
