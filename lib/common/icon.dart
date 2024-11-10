import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum DIcon$Name {
  apple,
  bellCoin,
  bellVoucher,
  blathers,
  celeste,
  cherry,
  coconut,
  daisyMae,
  fossil,
  giftbox,
  isabelle,
  kkSlider,
  leaf,
  moneyBag,
  nookMiles,
  orange,
  orville,
  peach,
  pear,
  recipeCard,
  redd,
  starFragmentWhite,
  starFragmentYellow,
  timmyNook,
  tomNook,
  tommyNook,
  wilbur,
  wisp;

  static const String assetPath = 'assets/svgs';

  String get toAssetPath => '$assetPath/$name.svg';
}

class DIcon extends StatelessWidget {
  DIcon({
    super.key,
    required this.iconName,
  });

  DIcon$Name iconName;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconName.toAssetPath,
      height: 100,
      width: 100,
    );
  }
}
