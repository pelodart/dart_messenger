abstract class Message {
  final String _sender;
  final String _recipient;
  final String _text;

  Message(String sender, String recipient, String text)
      : _sender = sender,
        _recipient = recipient,
        _text = text {}

  // getter/setter
  String get Sender => _sender;
  String get Recipient => _recipient;
  String get Text => _text;

  // public interface
  bool recipientEquals(String name) {
    return _recipient == name;
  }

  @override
  String toString() {
    return 'Sender: ${_sender}, Recipient: ${_recipient}, Text: ${_text}';
  }
}

class RegularMessage extends Message {
  RegularMessage(String sender, String recipient, String text)
      : super(sender, recipient, text) {}

  @override
  String toString() {
    return 'Regular  Message --> ${super.toString()}';
  }
}

class PriorityMessage extends Message {
  PriorityMessage(String sender, String recipient, String text)
      : super(sender, recipient, text) {}

  @override
  String toString() {
    return 'Priority Message ==> ${super.toString()}';
  }
}
