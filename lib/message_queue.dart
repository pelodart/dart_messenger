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
    // first pass: search for priority messages
    for (int i = 0; i < _messages.length; i++) {
      if (_messages[i].Recipient == name) {
        if (_messages[i] is PriorityMessage) {
          Message found = _messages[i];
          _messages.removeAt(i);
          return found;
        }
      }
    }
    // second pass: search for regular messages, if any
    for (int i = 0; i < _messages.length; i++) {
      if (_messages[i].Recipient == name) {
        Message found = _messages[i];
        _messages.removeAt(i);
        return found;
      }
    }
    return null;
  }

  List<Message> removeMessages(String name) {
    List<Message> result = List<Message>();
    Message msg;
    while ((msg = removeMessage(name)) != null) {
      result.add(msg);
    }
    return result;
  }
}
