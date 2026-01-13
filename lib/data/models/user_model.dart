class UserModel {
  final int id;
  final String email;
  final String username;
  final String phone;
  final Name name;
  final Address address;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.phone,
    required this.name,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
      name: Name.fromJson(json['name'] ?? {}),
      address: Address.fromJson(json['address'] ?? {}),
    );
  }
}

class Name {
  final String firstname;
  final String lastname;

  Name({required this.firstname, required this.lastname});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
    );
  }
}

class Address {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final GeoLocation geolocation;

  Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city  '] ?? '',
      street: json['street'] ?? '',
      number: json['number'] ?? 0,
      zipcode: json['zipcode'] ?? '',
      geolocation: GeoLocation.fromJson(json['geolocation'] ?? {}),
    );
  }
}

class GeoLocation {
  final String lat;
  final String long;

  GeoLocation({required this.lat, required this.long});

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      lat: json['lat'] ?? json['latitude'] ?? '',
      long: json['long'] ?? json['longitude'] ?? '',
    );
  }
}
