class SuperModel<T>{  bool status;  String message;  T data;  SuperModel.fromJson(Map<String,dynamic> json,Function<T>(Map<String,dynamic>) create){    status=json['status'];    message=json['message'];    data=create(json['data']) ;  }}