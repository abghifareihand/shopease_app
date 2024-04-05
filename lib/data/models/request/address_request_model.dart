import 'dart:convert';

class AddressRequestModel {
    final String? name;
    final String? phone;
    final String? provinceId;
    final String? cityId;
    final String? subdistrictId;
    final String? postalCode;
    final String? fullAddress;
    final bool? isDefault;

    AddressRequestModel({
        this.name,
        this.phone,
        this.provinceId,
        this.cityId,
        this.subdistrictId,
        this.postalCode,
        this.fullAddress,
        this.isDefault,
    });

    factory AddressRequestModel.fromJson(String str) => AddressRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddressRequestModel.fromMap(Map<String, dynamic> json) => AddressRequestModel(
        name: json["name"],
        phone: json["phone"],
        provinceId: json["province_id"],
        cityId: json["city_id"],
        subdistrictId: json["subdistrict_id"],
        postalCode: json["postal_code"],
        fullAddress: json["full_address"],
        isDefault: json["is_default"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "phone": phone,
        "province_id": provinceId,
        "city_id": cityId,
        "subdistrict_id": subdistrictId,
        "postal_code": postalCode,
        "full_address": fullAddress,
        "is_default": isDefault,
    };
}
