class ProductModel {
  final String id;
  final String productCode;
  final String name;
  final String? description;
  final String category;
  final String? size;
  final String unit;
  final double purchasePrice;
  final double sellingPrice;
  final double wholesalePrice;
  final int minStock;
  final int maxStock;
  final int currentStock;
  final DateTime? lastPurchaseDate;
  final String? imageUrl;
  final String? barcode;
  final String status;

  ProductModel({
    required this.id,
    required this.productCode,
    required this.name,
    this.description,
    this.category = 'water',
    this.size,
    this.unit = 'bottle',
    this.purchasePrice = 0,
    required this.sellingPrice,
    this.wholesalePrice = 0,
    this.minStock = 0,
    this.maxStock = 999,
    this.currentStock = 0,
    this.lastPurchaseDate,
    this.imageUrl,
    this.barcode,
    this.status = 'active',
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      productCode: json['product_code'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      category: json['category'] ?? 'water',
      size: json['size'],
      unit: json['unit'] ?? 'bottle',
      purchasePrice: (json['purchase_price'] ?? 0).toDouble(),
      sellingPrice: (json['selling_price'] ?? 0).toDouble(),
      wholesalePrice: (json['wholesale_price'] ?? 0).toDouble(),
      minStock: json['min_stock'] ?? 0,
      maxStock: json['max_stock'] ?? 999,
      currentStock: json['current_stock'] ?? 0,
      lastPurchaseDate: json['last_purchase_date'] != null 
          ? DateTime.parse(json['last_purchase_date']) 
          : null,
      imageUrl: json['image_url'],
      barcode: json['barcode'],
      status: json['status'] ?? 'active',
    );
  }
}
