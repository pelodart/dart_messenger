import 'message.dart';

class MessageQueue {
  List<Message> _messages;

  MessageQueue() {
    _messages = List<Message>();
  }

  // getter/setter
  int get Count => _messages.length;

  // public interface
  void addMessage(Message message) {
    _messages.add(message);
  }

  Message removeMessage(String name) {
    Message found = null;
    for (int i = 0; i < _messages.length; i++) {
      if (_messages[i].recipientEquals(name)) {
        found = _messages[i];
        _messages.removeAt(i);
        break;
      }
    }
    return found;
  }

  List<Message> allMessagesForUser(String name) {
    List<Message> result = List<Message>();
    for (int i = 0; i < _messages.length; i++) {
      if (_messages[i].recipientEquals(name)) {
        result.add(_messages[i]);
      }
    }
    return result;
  }
}
