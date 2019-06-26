import 'message.dart';
import 'message_queue.dart';
import 'user_repository.dart';

class MessengerService {
  MessageQueue _messages;
  UserRepository _users;

  MessengerService() {
    _messages = MessageQueue();
    _users = UserRepository();
  }

  bool registerUser(String name) {
    if (_users.containsUser(name)) return false;
    return _users.addUser(name);
  }

  bool unregisterUser(String name) {
    if (!_users.containsUser(name)) return false;
    return _users.removeUser(name);
  }

  bool send(String from, String to, String text) {
    if (!_users.containsUser(from)) return false;
    if (!_users.containsUser(to)) return false;

    Message msg = Message(from, to, text);
    _messages.addMessage(msg);
    return true;
  }

  Message receive(String name) {
    if (!_users.containsUser(name)) return null;
    return _messages.removeMessage(name);
  }
}
