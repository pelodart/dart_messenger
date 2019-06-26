import 'message.dart';
import 'message_queue.dart';
import 'user_repository.dart';

// class Messenger {
//   MessageQueue _messages;
//   UserRepository _users;

//   Messenger() {
//     _messages = MessageQueue();
//     _users = UserRepository();
//   }

//   bool registerUser(String name) {
//     if (_users.containsUser(name)) return false;
//     return _users.addUser(name);
//   }

//   bool unregisterUser(String name) {
//     if (!_users.containsUser(name)) return false;
//     return _users.removeUser(name);
//   }

//   bool send(String from, String to, String text) {
//     if (!_users.containsUser(from)) return false;
//     if (!_users.containsUser(to)) return false;

//     Message msg = Message(from, to, text);
//     _messages.addMessage(msg);
//     return true;
//   }

//   Message receive(String name) {
//     if (!_users.containsUser(name)) return null;
//     return _messages.removeMessage(name);
//   }

//   List<Message> receiveAllMessages(String name) {
//     return _messages.removeMessages(name);
//   }
// }

class PriorityMessenger /* extends Messenger  */ {
  UserRepository _users;
  PriorityMessageQueue _messages;

  PriorityMessenger() {
    _messages = PriorityMessageQueue();
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

    RegularMessage msg = RegularMessage(from, to, text);
    _messages.addMessage(msg);
    return true;
  }

    bool sendPrio(String from, String to, String text) {
    if (!_users.containsUser(from)) return false;
    if (!_users.containsUser(to)) return false;

    PriorityMessage msg = PriorityMessage(from, to, text);
    _messages.addMessage(msg);
    return true;
  }

  Message receive(String name) {
    if (!_users.containsUser(name)) return null;
    return _messages.removeMessage(name);
  }

  List<Message> receiveAllMessages(String name) {
    return _messages.removeMessages(name);
  }
}
