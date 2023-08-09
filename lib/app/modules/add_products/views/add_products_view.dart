import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_products_controller.dart';

class AddProductsView extends GetView<AddProductsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD PRODUCT'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.codeC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: const InputDecoration(
              labelText: "Product Code",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: controller.namaC,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: "Nama Product",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: controller.qtyC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Qty",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  if (controller.codeC.text.isNotEmpty &&
                      controller.namaC.text.isNotEmpty &&
                      controller.qtyC.text.isNotEmpty) {
                    controller.isLoading(true);
                    Map<String, dynamic> hasil = await controller.addProduct({
                      "code": controller.codeC.text,
                      "nama": controller.namaC.text,
                      "qty": int.tryParse(controller.qtyC.text) ?? 0,
                    });
                    controller.isLoading(false);

                    Get.back();

                    Get.snackbar(hasil["error"] == true ? "Error" : "Success",
                        hasil["message"]);
                  }
                } else {
                  Get.snackbar("Error", "Semua Data Wajic Diisi");
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20)),
              child: Text(
                  controller.isLoading.isFalse ? "ADD PRODUCT" : "LOADING..."),
            ),
          ),
        ],
      ),
    );
  }
}
