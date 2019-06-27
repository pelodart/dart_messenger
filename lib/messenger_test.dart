import 'message.dart';
import 'messenger.dart';
import 'user_repository.dart';

void testUserRepository() {
  UserRepository testRepository = UserRepository();
  testRepository.addUser("Franz");
  testRepository.addUser("Hans");
  testRepository.addUser("Sepp");
  if (!testRepository.containsUser("Hans")) {
    testRepository.addUser("Hans");
  }

  print("UserRepository: ${testRepository.Count} entries.");
  print(testRepository);
}

void testMessages() {
  PriorityMessage msg1 = PriorityMessage('Hans', 'Sepp', "What's going on ...");
  RegularMessage msg2 = RegularMessage('Sepp', 'Hans', 'Nothing !');
  print(msg1);
  print(msg2);
}

void testMessenger01() {
  Messenger myMessenger = Messenger();
  Message msg;

  myMessenger.registerUser("Franz");
  myMessenger.registerUser("Susan");

  print("Sending: From: Franz, To: Susan, Text: [First Message]");
  myMessenger.send("Franz", "Susan", "First Message");
  print("Sending: From: Franz, To: Susan, Text: [Second Message]");
  myMessenger.send("Franz", "Susan", "Second Message");

  msg = myMessenger.receive("Susan");
  print("Received: ");
  print(msg);
  msg = myMessenger.receive("Susan");
  print("Received: ");
  print(msg);
}

void testMessenger02() {
  Messenger myMessenger = Messenger();
  Message msg;

  myMessenger.registerUser("Franz");
  myMessenger.registerUser("Susan");

  myMessenger.send("Franz", "Susan", "1. Message");
  myMessenger.sendPrio("Franz", "Susan", "2. Message");
  myMessenger.send("Franz", "Susan", "3. Message");
  myMessenger.sendPrio("Franz", "Susan", "4. Message");
  myMessenger.send("Franz", "Susan", "5. Message");
  myMessenger.sendPrio("Franz", "Susan", "6. Message");
  myMessenger.send("Franz", "Susan", "7. Message");
  myMessenger.sendPrio("Franz", "Susan", "8. Message");

  while ((msg = myMessenger.receive("Susan")) != null) {
    print(msg);
  }
}

void testMessenger03() {
  Messenger myMessenger = Messenger();
  myMessenger.registerUser("Franz");
  myMessenger.registerUser("Susan");
  myMessenger.registerUser("Sepp");

  myMessenger.send("Franz", "Susan", "1. Message");
  myMessenger.send("Franz", "Sepp", "2. Message");
  myMessenger.send("Franz", "Susan", "3. Message");
  myMessenger.sendPrio("Franz", "Sepp", "4. Message");
  myMessenger.send("Franz", "Susan", "5. Message");
  myMessenger.send("Franz", "Sepp", "6. Message");
  myMessenger.send("Franz", "Susan", "7. Message");
  myMessenger.sendPrio("Franz", "Sepp", "8. Message");

  List<Message> messagesForSepp = myMessenger.receiveAllMessages('Sepp');
  for (Message message in messagesForSepp) {
    print("Received: ${message}");
  }
}
