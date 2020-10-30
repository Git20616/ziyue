class SimpleUser {
  final String name;
  final String email;

  SimpleUser(this.name, this.email);

  SimpleUser.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        email = json["email"];
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"name": name, "email": email};
}
