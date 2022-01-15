import 'package:flutter/material.dart';
import 'package:taxes/controllers/taxdef_controller.dart';
import 'package:taxes/widgets/TextWidget.dart';
import 'package:taxes/widgets/clippper.dart';
import 'package:taxes/widgets/st_widget.dart';
import 'drawer.dart';
import 'package:get/get.dart';
class TaxDef extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(context),
      body: SafeArea(
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 00,
                ),
                Stack(
                  children: const [
                    Clipper(),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: MyText(
                          text: "FAQ",
                          fontColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          size: 60.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: GetBuilder<TaxdefController>(
                        init: TaxdefController(),
                        builder: (controller) {
                            return ListView.builder(
                                itemCount: controller.trailshort.length,
                                itemBuilder: (context, int index) {
                                  return Align(
                                      alignment: Alignment.center,
                                      child: ShortTerm_W(controller.trailshort[index]['questions'],
                                          controller.trailshort[index]['answers']));
                                });
                        }
                    )
                ),
              ],
            )),
      ),
    );
  }
}
