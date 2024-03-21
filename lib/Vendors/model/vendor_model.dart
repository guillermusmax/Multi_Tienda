class VendorModel {
  final String vendorId;
  final bool approve;
  final String businessName;
  final String email;
  final String phoneNumber;
  final String country;
  final String state;
  final String city;
  final String taxTypeSelection;
  final String rnc;
  final String image;

  VendorModel({
    required this.vendorId,
    required this.approve,
    required this.businessName,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.state,
    required this.city,
    required this.taxTypeSelection,
    required this.rnc,
    required this.image,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
    vendorId: json["vendorId"],
    approve: json["approve"],
    businessName: json["businessName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    taxTypeSelection: json["taxTypeSelection"],
    rnc: json["rnc"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "vendorId": vendorId,
    "approve": approve,
    "businessName": businessName,
    "email": email,
    "phoneNumber": phoneNumber,
    "country": country,
    "state": state,
    "city": city,
    "taxTypeSelection": taxTypeSelection,
    "rnc": rnc,
    "image": image,
  };
}