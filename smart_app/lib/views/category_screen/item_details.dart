import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_app/consts/consts.dart';
import 'package:smart_app/widgets_common/our_button.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final String? imgs;
  final String? price;
  final String? quantity;
  final String? desc;

  // const ItemDetails({super.key, required this.title, required QueryDocumentSnapshot<Object?> data});
  const ItemDetails(
      {super.key,
      required this.title,
      required this.imgs,
      required this.price,
      required this.quantity,
      required this.desc,
      required QueryDocumentSnapshot<Object?> data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: title!.text.white.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outline,
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //swipper section

                VxSwiper.builder(
                  autoPlay: true,
                  height: 350,
                  itemCount: 3,
                  aspectRatio: 16 / 9,
                  itemBuilder: (context, index) {
                    return Image.network(
                      // imgFc5,
                      imgs!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                ),

                10.heightBox,
                //title and detail section
                title!.text
                    .size(16)
                    .color(darkFontGrey)
                    .fontFamily(bold)
                    .make(),
                10.heightBox,
                //rating
                VxRating(
                  onRatingUpdate: (value) {},
                  normalColor: textfieldGrey,
                  selectionColor: golden,
                  count: 5,
                  size: 25,
                  stepInt: true,
                ),

                10.heightBox,
                Row(
                  children: [
                    "\$".text.color(redColor).fontFamily(bold).size(18).make(),
                    price!.text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),
                  ],
                ),
                // price!.text.color(redColor).fontFamily(bold).size(18).make(),
                10.heightBox,

                Row(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Seller".text.white.fontFamily(semibold).make(),
                        5.heightBox,
                        "In House Brands"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .size(16)
                            .make()
                      ],
                    )),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.message_rounded, color: darkFontGrey),
                    ),
                  ],
                )
                    .box
                    .height(60)
                    .padding(const EdgeInsets.symmetric(horizontal: 16))
                    .color(textfieldGrey)
                    .make(),

                //color section
                20.heightBox,
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          // child: "Color: ".text.color(textfieldGrey).make(),
                          child: "Color: ".text.make(),
                        ),
                        Row(
                          children: List.generate(
                              3,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .roundedFull
                                  .color(Vx.randomPrimaryColor)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .make()),
                        ),
                      ],
                    ).box.padding(const EdgeInsets.all(8)).make(),

                    //quantity row
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          // child: "Quantity: ".text.color(textfieldGrey).make(),
                          child: "Quantity: ".text.make(),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove)),
                            "0"
                                .text
                                .size(16)
                                .color(darkFontGrey)
                                .fontFamily(bold)
                                .make(),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.add)),
                            10.widthBox,
                            // "(0 available)".text.color(textfieldGrey).make(),
                            // "(0 available)".text.make(),
                            quantity!.text.make(),
                            " available".text.make()
                          ],
                        ),
                      ],
                    ).box.padding(const EdgeInsets.all(8)).make(),

                    //total row
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          // child: "Total: ".text.color(textfieldGrey).make(),
                          child: "Total: ".text.make(),
                        ),
                        "\$0.00"
                            .text
                            .color(redColor)
                            .size(16)
                            .fontFamily(bold)
                            .make(),
                      ],
                    ).box.padding(const EdgeInsets.all(8)).make(),
                  ],
                ).box.white.shadowSm.make(),

                //description section
                10.heightBox,

                "Description"
                    .text
                    .color(darkFontGrey)
                    .fontFamily(semibold)
                    .make(),
                10.heightBox,
                // "This is a dummy item and dummy description here...aassddḍ dssda dsds sdsdsd dsdsdsd"
                desc!.text.color(darkFontGrey).make(),
              ],
            )),
          )),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
                color: redColor,
                onPress: () {},
                textColor: whiteColor,
                title: "Add to cart"),
          )
        ],
      ),
    );
  }
}
