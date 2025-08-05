abstract class BaseUser {
  final String uid;
  final String email;
  final String name;
  final String? phone;

  BaseUser({
    required this.uid,
    required this.email,
    required this.name,
    this.phone,
  });

  Map<String, dynamic> toMap();
}

// Trainer Model
class TrainerModel extends BaseUser {
  final String specialization;

  TrainerModel({
    required String uid,
    required String email,
    required String name,
    required this.specialization,
    String? phone,
  }) : super(uid: uid, email: email, name: name, phone: phone);

  @override
  Map<String, dynamic> toMap() => {
        'uid': uid,
        'email': email,
        'name': name,
        'specialization': specialization,
        'phone': phone,
      };

  factory TrainerModel.fromMap(Map<String, dynamic> data) {
    return TrainerModel(
      uid: data['uid'],
      email: data['email'],
      name: data['name'],
      specialization: data['specialization'],
      phone: data['phone'],
    );
  }
}
