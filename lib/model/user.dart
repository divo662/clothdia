
// MODEL CLASS FOR LOGIN FIREBASE FORM AND REGISTER FIREBASE FORM///////////
class UserModel{
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  bool isActive = true;

  UserModel({this.uid, this.email, this.firstName, this.secondName});
  //RECEIVING DATA FROM THE SERVER///////////////////////////////////
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map["uid"],
      email: map["email"],
      firstName: map["firstName"],
      secondName: map["secondName"],
    );
  }

// SENDING DATA TO THE SERVER////////////////////////////////////////
  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "email": email,
      "firstName": firstName,
      "secondName": secondName,
    };
  }
}