class Message {
  String _sender;
  String _recipient;
  String _text;

  Message(String sender, String recipient, String text)
      : _sender = sender,
        _recipient = recipient,
        _text = text {}

  // Message()
  //     : _sender = '',
  //       _recipient = '',
  //       _text = '' {}

// TODO: Clone entfernen .. dann aber Message immutable machen ,,,,

  // Message.clone(Message message)
  //     : _sender = message._sender,
  //       _recipient = message._sender,
  //       _text = message._sender {}

  // getter/setter
  String get Sender => _sender;
  String get Recipient => _recipient;
  String get Text => _text;
  set Sender(String value) => _sender = value;
  set Recipient(String value) => _recipient = value;
  set Text(String value) => _text = value;

  // public interface
  bool recipientEquals(String name) {
    return _recipient == name;
  }

  @override
  String toString() {
    return 'Sender: ${_sender}, Recipient: ${_recipient}, Text: ${_text}';
  }
}
