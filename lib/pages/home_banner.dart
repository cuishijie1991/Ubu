import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_website/utils/utils.dart';

class HomeBannerWidget extends StatelessWidget {
  final List<String> pics = [
    "assets/images/3.0x/bg_splash.jpg",
    "assets/images/3.0x/bg_splash.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    double _width, _height;
    _width = MediaQuery.of(context).size.width;
    double ratio = 540.0 / 1080.0;
    _height = _width * ratio;
    return Container(
        width: _width,
        height: _height,
        child: Swiper(
          containerWidth: _width,
          containerHeight: _height,
          outer: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Image.asset(
                pics[index],
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: pics.length,
          onIndexChanged: (index) {
//            Tool.toast("$index is changed");
          },
          scrollDirection: Axis.horizontal,
          autoplay: true,
        ));
  }
}
