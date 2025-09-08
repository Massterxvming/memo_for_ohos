//生成一个userModel,包含id,name,age,email,phone,address,createdAt,updatedAt字段
class UserModel {
  String id;
  String name;
  int age;
  String email;
  String phone;
  String address;
  DateTime createdAt;
  DateTime updatedAt;
  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      'address': address,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserModel.empty() {
    return UserModel(
      id: '',
      name: '',
      age: 0,
      email: '',
      phone: '',
      address: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
//   /// 今天 -> 'HH:mm'
//   /// 昨天 -> '昨天 HH:mm'