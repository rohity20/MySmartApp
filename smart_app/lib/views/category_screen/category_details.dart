import 'package:smart_app/consts/consts.dart';
import 'package:smart_app/views/category_screen/item_details.dart';
import 'package:smart_app/widgets_common/bg_widget.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});
  // const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: title!.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    6,
                    (index) => "Baby Clothing"
                        .text
                        .size(12)
                        .fontFamily(semibold)
                        // .color(darkFontGrey)
                        .color(whiteColor)
                        .makeCentered()
                        .box
                        // .white
                        .pink500
                        .rounded
                        .size(120, 60)
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .make()),
              )),

          20.heightBox,

          //items container
          Expanded(
            //   child: Container(
            // color: lightGrey,
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8),
                itemBuilder: ((context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        imgP5,
                        height: 150,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      "Laptop 4GB/64GB"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      "\$600"
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(16)
                          .make(),
                      10.heightBox,
                    ],
                  )
                          .box
                          .white
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .roundedSM
                          .outerShadowSm
                          .padding(const EdgeInsets.all(12))
                          .make()
                      //     .onTap(() {
                      //   Get.to(() => const ItemDetails(title: "Dummy item"));
                      // })
                      ;
                })),
            // )
          )
        ]),
      ),
    ));
  }
}
