import 'dart:math';
import 'dart:ui';

Color whiteColor=const Color(0xffFFFFFF);
Color Gunmetal = const Color(0xff2E2739);
Color blackColor = const Color(0xff202C43);
Color fontColor = const Color(0xff8F8F8F);
Color lightBlue = const Color(0xff61C3F2);
Color lightCream = const Color(0xffDBDBDF);
Color yellow= const Color(0xffCD9D0F);
Color blue= const Color(0xff564CA3);
Color primary =const Color(0xffDBDBDF);
Color primaryColor =const Color(0xff242A32);
Color colorBlue = const Color(0xff0296E5);
Color lightPrimary = const Color(0xff67686D);
Color orange = const Color(0xffFF8700);





Color getRandomColor() {
  final Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1.0,
  );
}
