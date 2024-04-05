import 'dart:convert';

class AddressResponseModel {
    final int? code;
    final bool? success;
    final String? message;
    final List<Address>? data;

    AddressResponseModel({
        this.code,
        this.success,
        this.message,
        this.data,
    });

    factory AddressResponseModel.fromJson(String str) => AddressResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddressResponseModel.fromMap(Map<String, dynamic> json) => AddressResponseModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Address>.from(json["data"]!.map((x) => Address.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Address {
    final int? id;
    final int? userId;
    final String? name;
    final String? phone;
    final String? provinceId;
    final String? cityId;
    final String? subdistrictId;
    final String? postalCode;
    final String? fullAddress;
    final int? isDefault;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Address({
        this.id,
        this.userId,
        this.name,
        this.phone,
        this.provinceId,
        this.cityId,
        this.subdistrictId,
        this.postalCode,
        this.fullAddress,
        this.isDefault,
        this.createdAt,
        this.updatedAt,
    });

    factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Address.fromMap(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        provinceId: json["province_id"],
        cityId: json["city_id"],
        subdistrictId: json["subdistrict_id"],
        postalCode: json["postal_code"],
        fullAddress: json["full_address"],
        isDefault: json["is_default"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "province_id": provinceId,
        "city_id": cityId,
        "subdistrict_id": subdistrictId,
        "postal_code": postalCode,
        "full_address": fullAddress,
        "is_default": isDefault,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
