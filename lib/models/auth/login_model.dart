class LoginModel {
  int? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? loginId;
  String? email;
  String? password;
  String? phone;
  int? status;
  int? isActive;
  String? createdOn;
  String? createdBy;
  String? updatedOn;
  String? updatedBy;
  String? token;
  int? driverId;
  DeliveryPerson? deliveryPerson;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.loginId,
      this.email,
      this.password,
      this.phone,
      this.status,
      this.isActive,
      this.createdOn,
      this.createdBy,
      this.updatedOn,
      this.updatedBy,
      this.token,
      this.driverId,
      this.deliveryPerson});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    loginId = json['loginId'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    status = json['status'];
    isActive = json['isActive'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    updatedOn = json['updatedOn'];
    updatedBy = json['updatedBy'];
    token = json['token'];
    driverId = json['driverId'];
    driverId = json['driver_id'];
    deliveryPerson = json['DeliveryPerson'] != null
        ? DeliveryPerson.fromJson(json['DeliveryPerson'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['loginId'] = loginId;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['status'] = status;
    data['isActive'] = isActive;
    data['createdOn'] = createdOn;
    data['createdBy'] = createdBy;
    data['updatedOn'] = updatedOn;
    data['updatedBy'] = updatedBy;
    data['token'] = token;
    data['driverId'] = driverId;
    data['driver_id'] = driverId;
    if (deliveryPerson != null) {
      data['DeliveryPerson'] = deliveryPerson!.toJson();
    }
    return data;
  }
}

class DeliveryPerson {
  int? id;
  String? firstName;
  String? lastName;
  String? loginId;
  String? email;
  String? password;
  int? status;
  int? isActive;
  String? contactNo;
  String? createdOn;
  String? updatedOn;
  int? companyId;
  String? token;
  String? type;

  DeliveryPerson(
      {this.id,
      this.firstName,
      this.lastName,
      this.loginId,
      this.email,
      this.password,
      this.status,
      this.isActive,
      this.contactNo,
      this.createdOn,
      this.updatedOn,
      this.companyId,
      this.token,
      this.type});

  DeliveryPerson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    loginId = json['loginId'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    isActive = json['isActive'];
    contactNo = json['contactNo'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    companyId = json['companyId'];
    token = json['token'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['loginId'] = loginId;
    data['email'] = email;
    data['password'] = password;
    data['status'] = status;
    data['isActive'] = isActive;
    data['contactNo'] = contactNo;
    data['createdOn'] = createdOn;
    data['updatedOn'] = updatedOn;
    data['companyId'] = companyId;
    data['token'] = token;
    data['type'] = type;
    return data;
  }
}
