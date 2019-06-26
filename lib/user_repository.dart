class UserRepository {
  List<String> _userNames;

  UserRepository() {
    _userNames = List<String>();
  }

  // getter/setter
  int get Count => _userNames.length;

  // public interface
  bool containsUser(String name) {
    return _userNames.indexOf(name) != -1;
  }

  bool addUser(String name) {
    if (containsUser(name)) {
      return false;
    }

    _userNames.add(name);
    return true;
  }

  bool removeUser(String name) {
    if (containsUser(name)) {
      return false;
    }

    int index = _userNames.indexOf(name);
    _userNames.removeAt(index);
    return true;
  }

  @override
  String toString() {
    String s = "";
    for (int i = 0; i < _userNames.length; i++) {
      s += "${i+1}: ${_userNames[i]}\n";
    }
    return s;
  }
}
