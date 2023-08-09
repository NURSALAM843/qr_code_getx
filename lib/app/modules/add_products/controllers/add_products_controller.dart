import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddProductsController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController codeC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController qtyC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      //store
      var hasil = await firestore.collection("products").add(data);

      //update buuat masukkan productID
      await firestore.collection("products").doc(hasil.id).update({
        "productId": hasil.id,
      });
      return {
        "error": false,
        "message": "Berhasil Menambah Product",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak Dapat Menambah Product",
      };
    }
  }
}
