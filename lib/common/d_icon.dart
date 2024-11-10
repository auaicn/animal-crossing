import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart' as p;

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

  String get toAssetPath => p.join(assetPath, '$name.svg');
}

class DIcon extends StatelessWidget {
  DIcon({
    super.key,
    required this.iconName,
    this.size = 24,
  });

  DIcon$Name iconName;
  double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconName.toAssetPath,
      height: size,
      width: size,
    );
  }
}
