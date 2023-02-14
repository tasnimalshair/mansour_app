class HomeModel {
  bool? status;
  String? message;
  HomeDataModel? data;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    print('stat: $status');
    message = json['message'];
    print('msg: $message');
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
    print('jj');
    print('fromjson: $status $message $data}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeDataModel {
  List<Banners>? banners;
  List<Products>? products;
  String? ad;

  HomeDataModel({this.banners, this.products, this.ad});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    print('from data json');
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    ad = json['ad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['ad'] = this.ad;
    return data;
  }
}

class Banners {
  dynamic? id;
  String? image;
  String? category;
  String? product;

  Banners({this.id, this.image, this.category, this.product});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
    print('panners finish');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['category'] = this.category;
    data['product'] = this.product;
    return data;
  }
}

class Products {
  dynamic? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Products(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description,
      this.images,
      this.inFavorites,
      this.inCart});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    print('products finish');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    data['in_favorites'] = this.inFavorites;
    data['in_cart'] = this.inCart;
    return data;
  }
}



// class HomeModel {
//    bool? status;
//    String message;
//    Data data;

//   HomeModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
//   }
// }

// class Data {
//   late List<BannersModel> banners;
//   late List<ProductModel> products;
//   late String ad;

//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['banners'] != null) {
//       banners = <BannersModel>[];
//       json['banners'].forEach((v) {
//         banners.add(new BannersModel.fromJson(v));
//       });
//     }
//     if (json['products'] != null) {
//       products = <ProductModel>[];
//       json['products'].forEach((v) {
//         products.add(new ProductModel.fromJson(v));
//       });
//     }
//     ad = json['ad'];
//   }
// }

// class BannersModel {
//   late int id;
//   late String image;
//   late List category;
//   late List product;

//   BannersModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//     category = json['category'];
//     product = json['product'];
//   }
// }

// class ProductModel {
//   late int id;
//   late double price;
//   late double oldPrice;
//   late int discount;
//   late String image;
//   late String name;
//   late String description;
//   late List<String> images;
//   late bool inFavorites;
//   late bool inCart;

//   ProductModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//     images = json['images'].cast<String>();
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }
// }
