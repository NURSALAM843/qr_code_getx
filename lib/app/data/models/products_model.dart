class ProductModel {
  final String code;
  final String nama;
  final String productId;
  final int qty;

  ProductModel({
    required this.code,
    required this.nama,
    required this.productId,
    required this.qty,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        code: json["code"] ?? "",
        nama: json["nama"] ?? "",
        productId: json["productId"] ?? "",
        qty: json["qty"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "nama": nama,
        "productId": productId,
        "qty": qty,
      };
}
