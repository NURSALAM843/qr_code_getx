import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_getx/app/data/models/products_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/detail_products_controller.dart';

class DetailProductsView extends GetView<DetailProductsController> {
  DetailProductsView({super.key});

  final ProductModel product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.namaC.text = product.nama;
    controller.codeC.text = product.code;
    controller.qtyC.text = product.qty.toString();
    // controller.qtyC.text = "${product.qty}";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Products'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: QrImage(
                  data: product.code,
                  size: 200.0,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: controller.codeC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            maxLength: 10,
            readOnly: true,
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
                  if (controller.namaC.text.isNotEmpty &&
                      controller.qtyC.text.isNotEmpty) {
                    controller.isLoading(true);
                    Map<String, dynamic> hasil = await controller.editProduct({
                      "id": product.productId,
                      "nama": controller.namaC.text,
                      "qty": int.tryParse(controller.qtyC.text) ?? 0,
                    });
                    controller.isLoading(false);

                    Get.back();

                    Get.snackbar(hasil["error"] == true ? "Error" : "Success",
                        hasil["message"],
                        duration: const Duration(seconds: 2));
                  }
                } else {
                  Get.snackbar("Error", "Semua Data Wajib Diisi",
                      duration: const Duration(seconds: 2));
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20)),
              child: Text(controller.isLoading.isFalse
                  ? "UPDATE PRODUCT"
                  : "LOADING..."),
            ),
          ),
          TextButton(
            onPressed: () {
              //
              Get.defaultDialog(
                  barrierDismissible: false,
                  title: "Delete Product",
                  middleText: "Are You Sure To Delete This Product",
                  actions: [
                    OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text("CANCEL"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        controller.isLoadingDelete(true);
                        //proses
                        Map<String, dynamic> hasil =
                            await controller.deleteProduct(product.productId);
                        controller.isLoadingDelete(false);

                        //Balik Ke Page All Product
                        Get.back(); // tutup dialog
                        Get.back(); // Buat Balik Ke all product
                        Get.snackbar(
                            hasil["error"] == true ? "Error" : "Success",
                            hasil["message"],
                            duration: const Duration(seconds: 2));
                      },
                      child: Obx(
                        () => controller.isLoadingDelete.isFalse
                            ? const Text(
                                "Delete",
                              )
                            : Container(
                                padding: const EdgeInsets.all(2),
                                height: 15,
                                width: 15,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                ),
                              ),
                      ),
                    ),
                  ]);
            },
            child: Text(
              "DELETE PRODUCT",
              style: TextStyle(
                color: Colors.red[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
