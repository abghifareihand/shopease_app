import 'dart:convert';

class CategoryResponseModel {
    final int? code;
    final bool? success;
    final String? message;
    final List<Category>? data;

    CategoryResponseModel({
        this.code,
        this.success,
        this.message,
        this.data,
    });

    factory CategoryResponseModel.fromJson(String str) => CategoryResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CategoryResponseModel.fromMap(Map<String, dynamic> json) => CategoryResponseModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Category>.from(json["data"]!.map((x) => Category.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Category {
    final int? id;
    final String? name;
    final String? image;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Category({
        this.id,
        this.name,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
