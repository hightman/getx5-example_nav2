import 'package:example_nav2/app/modules/root/views/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.yellow,
          width: double.infinity,
          height: 25,
        ),
        Expanded(
          child: GetRouterOutlet.builder(
            route: Routes.home,
            builder: (context) {
              return Scaffold(
                drawer: const DrawerWidget(),
                appBar: AppBar(
                  title: Text(context.location),
                  centerTitle: true,
                ),
                body: GetRouterOutlet(
                  initialRoute: Routes.dashboard,
                  anchorRoute: Routes.home,
                  filterPages: (pages) {
                    var ret = pages.toList();
                    if (ret.isEmpty) {
                      ret.add(
                          context.delegate.matchRoute(Routes.dashboard).route!);
                    }
                    final nav = Get.nestedKey(Routes.home)
                        ?.navigatorKey
                        .currentState
                        ?.widget;
                    Get.log('Home filter pages: ${pages.map((e) => e.name)}');

                    if (nav != null) {
                      if (ret.isEmpty) {
                        Get.log(
                            "Home use olds: ${nav.pages.map((e) => e.name)}");
                        return nav.pages as List<GetPage>;
                      }
                      final sn = ret[0].name.split('/').length;
                      for (var p in nav.pages as List<GetPage>) {
                        if (p.maintainState &&
                            p.name.split('/').length == sn &&
                            !ret.contains(p)) {
                          ret.insert(0, p);
                        }
                      }
                    }
                    ret = ret
                        .where((e) => e.participatesInRootNavigator != true)
                        .toList();
                    Get.log('Home real pages: ${ret.map((e) => e.name)}');
                    return ret;
                  },
                ),
                bottomNavigationBar: IndexedRouteBuilder(
                    routes: const [
                      Routes.dashboard,
                      Routes.profile,
                      Routes.products
                    ],
                    builder: (context, routes, index) {
                      final delegate = context.delegate;
                      return BottomNavigationBar(
                        currentIndex: index,
                        onTap: (value) => delegate.toNamed(routes[value]),
                        items: const [
                          // _Paths.HOME + [Empty]
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: 'Home',
                          ),
                          // _Paths.HOME + Routes.PROFILE
                          BottomNavigationBarItem(
                            icon: Icon(Icons.account_box_rounded),
                            label: 'Profile',
                          ),
                          // _Paths.HOME + _Paths.PRODUCTS
                          BottomNavigationBarItem(
                            icon: Icon(Icons.account_box_rounded),
                            label: 'Products',
                          ),
                        ],
                      );
                    }),
              );
            },
          ),
        ),
      ],
    );
  }
}
