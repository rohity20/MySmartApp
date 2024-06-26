import 'package:smart_app/ChallanHistory.dart';
import 'package:smart_app/MyHomePage.dart';
import 'package:smart_app/consts/consts.dart';
import 'package:smart_app/controllers/home_controller.dart';
import 'package:smart_app/views/cart_screen/cart_screen.dart';
import 'package:smart_app/views/category_screen/category_screen.dart';
import 'package:smart_app/views/home_screen/home_screen.dart';
import 'package:smart_app/views/profile_screen.dart/profile_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //init home controller
    var controller = Get.put(HomeController());
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: account)
    ];

    var navBody = [
      // const HomeScreen(),
      MyHomePage(),
      const ChallanHistory(),
      const CartScreen(),
      const ProfileScreen()
    ];
    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(
              child: navBody.elementAt(controller.currentNavIndex.value))),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: Colors.blue[400],
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap: (value) => controller.currentNavIndex.value = value),
      ),
    );
  }
}
