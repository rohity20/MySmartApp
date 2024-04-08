import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_app/consts/consts.dart';
import 'package:smart_app/consts/lists.dart';
import 'package:smart_app/controllers/auth_controller.dart';
import 'package:smart_app/controllers/profile_controller.dart';
import 'package:smart_app/services/firestore_services.dart';
import 'package:smart_app/views/auth_screen/login_screen.dart';
import 'package:smart_app/views/profile_screen.dart/components/details_card.dart';
import 'package:smart_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FirestoreServices.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor)));
        } else {
          var data = snapshot.data!.docs[0];

          return SafeArea(
              child: Container(
            padding: const EdgeInsets.all(4),
            child: Column(children: [
              //edit profile button
              const Align(
                      alignment: Alignment.topRight,
                      // child: Icon(Icons.edit, color: whiteColor))
                      child: Icon(Icons.edit))
                  .onTap(() {}),
              Row(
                children: [
                  Image.asset(imgProfile2, width: 50, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make(),
                  20.widthBox,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // "Dummy User".text.fontFamily(semibold).white.make(),
                      // "customer@example.com".text.white.make(),
                      "${data['name']}".text.fontFamily(semibold).make(),
                      5.heightBox,
                      "${data['email']}".text.make(),
                    ],
                  )),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                      color: whiteColor,
                      // color: Colors.pink,
                    )),
                    onPressed: () async {
                      // await Get.put(AuthController()).signoutMethod(context);
                      Get.offAll(() => const LoginScreen());
                    },
                    child: logout.text.fontFamily(semibold).white.make(),
                  )
                ],
              ),

              10.heightBox,

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     detailsCard(
              //         count: data['cart_count'],
              //         title: "in your cart",
              //         width: context.screenWidth / 3.4),
              //     detailsCard(
              //         count: data['wishlist_count'],
              //         title: "in your wishlist",
              //         width: context.screenWidth / 3.4),
              //     detailsCard(
              //         count: data['order_count'],
              //         title: "your orders",
              //         width: context.screenWidth / 3.4),
              //   ],
              // ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Text(
              //       "Cart: ${data['cart_count']}",
              //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //     ),
              //     Text(
              //       "Wishlist: ${data['wishlist_count']}",
              //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //     ),
              //     Text(
              //       "Orders: ${data['order_count']}",
              //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Challan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color set to white
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white), // White border
                      borderRadius:
                          BorderRadius.circular(5), // Optional: Border radius
                    ),
                    child: Text(
                      "Total: ${data['cart_count']}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color set to white
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white), // White border
                      borderRadius:
                          BorderRadius.circular(5), // Optional: Border radius
                    ),
                    child: Text(
                      "Paid: ${data['wishlist_count']}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color set to white
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white), // White border
                      borderRadius:
                          BorderRadius.circular(5), // Optional: Border radius
                    ),
                    child: Text(
                      "Unpaid: ${data['order_count']}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color set to white
                      ),
                    ),
                  ),
                ],
              ),

              //buttons section
              10.heightBox, //40

              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const Divider(color: lightGrey);
                },
                itemCount: profileButtonList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.asset(
                      profileButtonIcon[index],
                      width: 22,
                    ),
                    title: profileButtonList[index]
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                  );
                },
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .shadowSm
                  .make(),

              appname.text.blue400.bold.make(),
              appversion.text.blue400.make(),
              // const Spacer(),
              // credits.text.pink400.fontFamily(semibold).make(),
            ]),
          ));
        }
      },
    )));
  }
}
