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

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(ProfileController());
//     // const userId = "6AUngRRpBNhuRR8fcGKoOg8njJa2";
//     // currentUser!.uid = "6AUngRRpBNhuRR8fcGKoOg8njJa2";
//     const currUser = {
//       "cart_count": "00",
//       "email": "roy@gmail.com",
//       "id": "6AUngRRpBNhuRR8fcGKoOg8njJa2",
//       "imageUrl": "",
//       "name": "Roy singh",
//       "order_count": "00",
//       "password": "123456",
//       "wishlist_count": "00",
//     };
//
//     return bgWidget(
//         child: Scaffold(
//             body: StreamBuilder(
//       stream: FirestoreServices.getUser(currentUser!.uid),
//       //    stream: FirestoreServices.getUser(currUser!.id),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         // if (!snapshot.hasData) {
//         if (!snapshot.hasData) {
//           return const Center(
//               child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation(redColor)));
//         } else {
//           var data = snapshot.data!.docs[0];
//
//           return SafeArea(
//               child: Container(
//             padding: const EdgeInsets.all(8),
//             child: Column(children: [
//               //edit profile button
//               const Align(
//                       alignment: Alignment.topRight,
//                       // child: Icon(Icons.edit, color: whiteColor))
//                       child: Icon(Icons.edit))
//                   .onTap(() {}),
//               Row(
//                 children: [
//                   Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
//                       .box
//                       .roundedFull
//                       .clip(Clip.antiAlias)
//                       .make(),
//                   10.widthBox,
//                   Expanded(
//                       child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       "Dummy User".text.fontFamily(semibold).white.make(),
//                       "customer@example.com".text.white.make(),
//                       // "${data['name']}".text.fontFamily(semibold).make(),
//                       // 5.heightBox,
//                       // "${data['email']}".text.make(),
//                     ],
//                   )),
//                   OutlinedButton(
//                     style: OutlinedButton.styleFrom(
//                         side: const BorderSide(
//                       // color: whiteColor,
//                       color: Colors.pink,
//                     )),
//                     onPressed: () async {
//                       // await Get.put(AuthController()).signoutMethod(context);
//                       Get.offAll(() => const LoginScreen());
//                     },
//                     child: logout.text.fontFamily(semibold).pink500.make(),
//                   )
//                 ],
//               ),
//
//               20.heightBox,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   detailsCard(
//                       count: data['cart_count'],
//                       title: "in your cart",
//                       width: context.screenWidth / 3.4),
//                   detailsCard(
//                       count: data['wishlist_count'],
//                       title: "in your wishlist",
//                       width: context.screenWidth / 3.4),
//                   detailsCard(
//                       count: data['order_count'],
//                       title: "your orders",
//                       width: context.screenWidth / 3.4),
//                 ],
//               ),
//
//               //buttons section
//               20.heightBox, //40
//
//               ListView.separated(
//                 shrinkWrap: true,
//                 separatorBuilder: (context, index) {
//                   return const Divider(color: lightGrey);
//                 },
//                 itemCount: profileButtonList.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     leading: Image.asset(
//                       profileButtonIcon[index],
//                       width: 22,
//                     ),
//                     title: profileButtonList[index]
//                         .text
//                         .fontFamily(semibold)
//                         .color(darkFontGrey)
//                         .make(),
//                   );
//                 },
//               )
//                   .box
//                   .white
//                   .rounded
//                   .padding(const EdgeInsets.symmetric(horizontal: 16))
//                   .shadowSm
//                   .make(),
//
//               appname.text.pink400.bold.make(),
//               appversion.text.pink400.make(),
//               // const Spacer(),
//               // credits.text.pink400.fontFamily(semibold).make(),
//             ]),
//           ));
//         }
//       },
//     )));
//   }
// }

// ===========================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    const userId = "6AUngRRpBNhuRR8fcGKoOg8njJa2";
    // currentUser!.uid = "6AUngRRpBNhuRR8fcGKoOg8njJa2";
    const currUser = {
      "cart_count": "00",
      "email": "roy@gmail.com",
      "id": "6AUngRRpBNhuRR8fcGKoOg8njJa2",
      "imageUrl": "",
      "name": "Roy singh",
      "order_count": "00",
      "password": "123456",
      "wishlist_count": "00",
    };

    return bgWidget(
        child: Scaffold(
            body: Scaffold(
              // stream: FirestoreServices.getUser(currentUser!.uid),
              //    stream: FirestoreServices.getUser(currUser!.id),
              // builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                // if (!snapshot.hasData) {
               if(userId == "adg") {
                  return const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor)));
                } else {
                //   var data = snapshot.data!.docs[0];
                  var data = currUser;

                  return SafeArea(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(children: [
                          //edit profile button
                          const Align(
                              alignment: Alignment.topRight,
                              // child: Icon(Icons.edit, color: whiteColor))
                              child: Icon(Icons.edit))
                              .onTap(() {}),
                          Row(
                            children: [
                              Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),
                              10.widthBox,
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "Dummy User".text.fontFamily(semibold).white.make(),
                                      "customer@example.com".text.white.make(),
                                      // "${data['name']}".text.fontFamily(semibold).make(),
                                      // 5.heightBox,
                                      // "${data['email']}".text.make(),
                                    ],
                                  )),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      // color: whiteColor,
                                      color: Colors.pink,
                                    )),
                                onPressed: () async {
                                  // await Get.put(AuthController()).signoutMethod(context);
                                  Get.offAll(() => const LoginScreen());
                                },
                                child: logout.text.fontFamily(semibold).pink500.make(),
                              )
                            ],
                          ),

                          20.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailsCard(
                                  count: data['cart_count'],
                                  title: "in your cart",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  count: data['wishlist_count'],
                                  title: "in your wishlist",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  count: data['order_count'],
                                  title: "your orders",
                                  width: context.screenWidth / 3.4),
                            ],
                          ),

                          //buttons section
                          20.heightBox, //40

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

                          appname.text.pink400.bold.make(),
                          appversion.text.pink400.make(),
                          // const Spacer(),
                          // credits.text.pink400.fontFamily(semibold).make(),
                        ]),
                      ));
                }
              // },
            )
      )
    );
  }
}

