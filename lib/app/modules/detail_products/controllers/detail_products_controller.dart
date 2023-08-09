import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailProductsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingDelete = false.obs;
  TextEditingController codeC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController qtyC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> editProduct(Map<String, dynamic> data) async {
    try {
      await firestore
          .collection("products")
          .doc(data["id"])
          .update({"nama": data["nama"], "qty": data["qty"]});
      return {
        "error": false,
        "message": "Berhasil Update Product",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak Dapat Update Product",
      };
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String id) async {
    try {
      await firestore.collection("products").doc(id).delete();
      return {
        "error": false,
        "message": "Berhasil Delete Product",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak Dapat Delete Product",
      };
    }
  }
}
