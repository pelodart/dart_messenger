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

  List<Message> removeMessages(String name) {
    List<Message> result = List<Message>();
    // first pass: collect messages
    for (int i = 0; i < _messages.length; i++) {
      if (_messages[i].recipientEquals(name)) {
        result.add(_messages[i]);
      }
    }

    // second pass: remove messages
    for (int i = 0; i < result.length; i++) {
      _messages.remove(result[i]);
    }

    return result;
  }
}

class PriorityMessageQueue extends MessageQueue {
  @override
  Message removeMessage(String name) {
    // first pass: search for priority messages
    for (int i = 0; i < _messages.length; i++) {
      if (_messages[i].recipientEquals(name)) {
        if (_messages[i] is PriorityMessage) {
          Message found = _messages[i];
          _messages.removeAt(i);
          return found;
        }
      }
    }
    // second pass: search for regular messages, if any
    return super.removeMessage(name);
  }
}
