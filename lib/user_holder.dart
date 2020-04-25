import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);
    print(user.toString());
    if (users.containsKey(user.login)) {
      throw Exception('A user with this name already exists');
    }
    users[user.login] = user;
  }

  User registerUserByEmail(String fullName, String email) {
    if (email.isEmpty) {
      throw Exception('email is empty');
    }
    if (users.containsKey(email)) {
      throw Exception('A user with this name already exists');
    }
    User user = User(name: fullName, email: email);
    users[user.email] = user;
    return user;
  }

  User registerUserByPhone(String fullName, String phone) {
    if (phone.isEmpty) {
      throw Exception('phone is empty');
    }
    String checkedPhone = User.checkPhone(phone);
    if (users.containsKey(checkedPhone)) {
      throw Exception('A user with this phone already exists');
    }
    User user = User(name: fullName, phone: checkedPhone);
    users[user.login] = user;
    return user;
  }

  User getUserByLogin(String login) {
    return users[login];
  }

  void setFriends(String login, List<User> friends) {
    User user = getUserByLogin(login);
    user.addFriend(friends);
  }

  User findUserInFriends(String login, User friend) {
    User user = getUserByLogin(login);
    for (User user in user.friends) {
      if (user == friend) {
        return user;
      }
    }
    throw Exception('${friend.login} is not a friend of the login');
  }

  List<User> importUsers(List<String> list) {
    List<User> users = [];

    for (String str in list) {
      List<String> data = str.split(';');
      var user = User(name: data[0].trim(), phone: data[2].trim(), email: data[1].trim());
      users.add(user);
    }

    return users;
  }
}
