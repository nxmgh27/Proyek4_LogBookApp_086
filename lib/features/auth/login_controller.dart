class LoginController {

  // Multiple Users
  final Map<String, String> _users = {
    "admin": "123",
    "user1": "abc",
  };

  bool login(String username, String password) {
    if (_users.containsKey(username) &&
        _users[username] == password) {
      return true;
    }
    return false;
  }
}
