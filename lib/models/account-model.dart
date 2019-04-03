class Account {
  static Account current;

  // TODO: implement fromApiResponse
  Account.fromApiResponse(Map<String, dynamic> json);

  // TODO: implement fromJson
  Account.fromJson(Map<String, dynamic> resp);

  // TODO: implement toJson
  Map<String, dynamic> toJson() => Map<String, dynamic>();
}
