import 'message.dart';
import 'messenger_service.dart';
import 'user_repository.dart';

void testUserRepository() {
  UserRepository testRepository = new UserRepository();
  testRepository.addUser("Franz");
  testRepository.addUser("Hans");
  testRepository.addUser("Sepp");
  if (!testRepository.containsUser("Hans")) {
    testRepository.addUser("Hans");
  }

  print("UserRepository: ${testRepository.Count} entries.");
  print(testRepository);
}

void testMessengerService() {
  MessengerService myMessenger = MessengerService();
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
