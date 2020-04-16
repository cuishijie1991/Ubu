import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_website/conf/application.dart';
import 'package:flutter_website/events/app_tab_change_event.dart';
import 'package:flutter_website/models/home/Banner.dart' as B;

class HomeBannerWidget extends StatelessWidget {
  final List<B.Banner> banners;

  const HomeBannerWidget(this.banners) : super();

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
              child: Image.network(
                banners[index].icon,
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: banners.length,
          onTap: (index) {
            print('ontap  banner $index');
            Application.eventBus.fire(HomeBottomTabChangeEvent('BaZi'));
          },
          scrollDirection: Axis.horizontal,
          autoplay: true,
        ));
  }
}
