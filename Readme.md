# Ein einfacher Nachrichten-Messenger in Dart

In dieser Aufgabe betrachten wir einen einfachen Nachrichten-Messenger im Sinne der bekannten Smartphone-Apps WhatsApp- oder Facebook-Messenger. Neben dem reinen Versenden von Nachrichten besitzt der Dart-Messenger auch eine Benutzerverwaltung.

Beide Teilnehmer (Sender und Empfänger) müssen am Messenger registriert sein, bevor sie Nachrichten senden oder empfangen können. Nachrichten gibt es in zwei Ausprägungen: Normale Nachrichten und Nachrichten mit Priorität. Sind einem Empfänger eine normale und eine Nachricht mit Priorität zugestellt, so ist ihm beim Abholen als Erstes die Nachricht mit Priorität auszuhändigen, unabhängig davon, in welcher Reihenfolge bzw. zu welchem Zeitpunkt beide Nachrichten abgesendet wurden.

Weitere Details entnehmen Sie den nachfolgenden Hinweisen zur Konzeption der einzelnen Dart-Klassen dieser Aufgabe.

## Klasse ``UserRepository``

| Element | Schnittstelle und Beschreibung |
|:-|:-|
| Konstruktor | ``UserRepository();``<br/> Legt ein leeres ``UserRepository``-Objekt an.|
| *getter* ``Count`` | ``int get Count`` <br/> Liefert die Anzahl der registrierten Namen zurück.|
| Methode ``addUser`` | ``bool addUser(String name);`` <br/> Fügt den Namen name eines Benutzers der Benutzerverwaltung hinzu. Ist der Name schon vorhanden, liefert die Methode den Wert ``false`` zurück, andernfalls ``true``.|
| Methode ``removeUser`` | ``bool removeUser(String name);`` <br/> Entfernt den Namen name eines Benutzers aus der Benutzerverwaltung. Konnte der Name erfolgreich entfernt werden, liefert die Methode den Wert ``true`` zurück, andernfalls ``false``.|
| Methode ``containsUser`` | ``bool containsUser(String name);`` <br/> Sieht in der Benutzerverwaltung nach, ob ein Name name vorhanden ist (Rückgabewert ``true``) oder nicht (Rückgabewert ``false``).|

Tabelle 1. Zentrale Elemente der Klasse ``UserRepository``.

Ein möglicher Testrahmen für die Benutzerverwaltung könnte so aussehen:

*Testrahmen*:

```dart
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
```

*Ausgabe*:

```
UserRepository: 3 entries.
1: Franz
2: Hans
3: Sepp
```

## Klasse ``Message``

Nachrichten werden vom Messenger intern in Objekten des Typs ``Message`` verwaltet. Im Instanzdatenbereich einer Nachricht sind drei Zeichenketten abzulegen:

*  Zeichenkette ``_sender`` – Name des Absenders. Muss in der Benutzerverwaltung vorhanden sein.
*  Zeichenkette ``_recipient`` – Name des Empfängers. Muss in der Benutzerverwaltung vorhanden sein.
*  Zeichenkette ``_text`` – Text der Nachricht. Eine Nachricht sollte beliebig lang sein können.

Implementieren Sie eine Klasse ``Message`` mit den drei Eigenschaften ``Sender``, ``Recipient`` und ``Text`` (*getter*-Methoden).

*Hinweis*: Die Anforderung „Name muss in der Benutzerverwaltung vorhanden sein“ können Sie erst zu einem späteren Zeitpunkt in der Realisierung umsetzen.

## Nachrichten mit und ohne Priorität

Modellieren Sie zwei Klassen ``RegularMessage`` und ``PriorityMessage``, die beide eine Spezialisierung der Klasse ``Message`` darstellen. Im Idealfall lässt es Ihre Realisierung zu, dass nur Objekte dieser beiden Klassen mit ``new`` angelegt werden können, also keine ``Message``-Objekte.

*Testrahmen*:

```dart
void testMessages() {
  PriorityMessage msg1 = PriorityMessage('Hans', 'Sepp', "What's going on ...");
  RegularMessage msg2 = RegularMessage('Sepp', 'Hans', 'Nothing !');
  print(msg1);
  print(msg2);
}
```

*Ausgabe*:

```
Priority Message ==> Sender: Hans, Recipient: Sepp, Text: What's going on ...
Regular  Message --> Sender: Sepp, Recipient: Hans, Text: Nothing !
```

## Klasse ``MessageQueue``

Kernstück des Messengers ist die Klasse ``MessageQueue``. In einem Objekt dieses Typs werden alle Nachrichten abgelegt, die versendet werden – und zu einem späteren Zeitpunkt ihrem Empfänger zugestellt werden. Also sowohl reguläre Nachrichten also auch Nachrichten mit Priorität. Legen Sie in Ihrer Realisierung der Klasse ``MessageQueue`` eine array-ähnliche Datenstruktur zu Grunde, die ``Message``-Objekte aufnehmen kann. Mit den beiden Methoden ``addMessage`` und ``removeMessage`` (siehe Tabelle 2) lassen sich in einem ``MessageQueue``-Objekt Nachrichten ablegen und entfernen:

| Element | Schnittstelle und Beschreibung |
|:-|:-|
| Konstruktor | ``MessageQueue();``<br/> Legt ein leeres ``MessageQueue``-Objekt an.|
| *getter* ``Count`` | ``int get Count`` <br/> Liefert die Anzahl aller Nachrichten im ``MessageQueue``-Objekt zurück.|
| Methode ``addMessage`` | ``void addMessage(Message message);`` <br/> Legt im ``MessageQueue``-Objekt eine Nachricht ab.|
| Methode ``removeMessage`` | ``Message removeMessage (String name);`` <br/> Entfernt im ``MessageQueue``-Objekt eine Nachricht, deren Empfänger durch den Parameter ``name`` vorgegeben ist und liefert diese durch den Rückgabeparameter zurück. Liegt für den Empfänger ``name`` keine Nachricht vor, liefert die Methode den Wert ``null`` zurück. Liegen für den Empänger sowohl normale als auch Nachrichten mit Priorität vor, so sind zuerst alle Nachrichten mit Priorität zu entfernen. Wird eine normale Nachricht entfernt, darf zu diesem Zeitpunkt keine Nachricht mit Priorität in der Nachrichtenwarteschlange sein! |
| Methode ``removeMessages`` | ``List<Message> removeMessages(String name);`` <br/> Liefert eine Liste mit allen Nachrichten zurück, die dem Empfänger ``name`` zugewiesen sind.|

Tabelle 2. Zentrale Elemente der Klasse ``MessageQueue``.

## Klasse ``Messenger``

Mit den geleisteten Vorarbeiten sollte es nun ein Einfaches sein, die Realisierung der Klasse Messenger
anzugehen. Diese besitzt für alle registrierten Benutzer und alle Nachrichten zwei Unterobjekte des Typs

*  ``UserRepository`` und
*  ``MessageQueue``

Alle Methoden der ``Messenger``-Klasse, die sich auf die Verwaltung der Benutzer beziehen, sind folglich auf das ``UserRepository``-Unterobjekt abzubilden – und alle Methoden zum Senden und Empfangen von Nachrichten offensichtlich auf das ``MessageQueue``-Unterobjekt. Damit sollte eine Implementierung der Methoden aus Tabelle 3 keine Probleme mehr bereiten:

| Element | Schnittstelle und Beschreibung |
|:-|:-|
| Konstruktor | ``Messenger();``<br/> Legt ein leeres ``Messenger``-Objekt an.|
| Methode ``registerUser`` | ``bool registerUser(String name);`` <br/> Meldet einen Benutzer mit dem Benutzernamen ``name`` in der Benutzerverwaltung des Nachrichtendienstes an. Ist der Name bereits vergeben, liefert die Methode ``false`` zurück, andernfalls ``true``.|
| Methode ``unregisterUser`` | ``bool unregisterUser(String name);`` <br/> Meldet einen Benutzer mit dem Benutzernamen ``name`` in der Benutzerverwaltung des Nachrichtendienstes ab. Kann der Name nicht gefunden werden, liefert die Methode ``false`` zurück, andernfalls ``true``.|
| Methode ``send`` | ``bool send (String from, String to, String text);`` <br/> Sendet eine Nachricht ``text`` mit Absender ``from`` an den Empfänger ``to``. An Hand der Parameter wird ein ``RegularMessage``-Objekt angelegt und im ``MessageQueue``-Unterobjekt abgelegt. Sender und Empfänger müssen in der Benutzerverwaltung registriert sein.|
| Methode ``sendPrio`` | ``bool sendPrio(String from, String to, String text);`` <br/> Siehe Beschreibung der ``send``-Methode mit dem Unterschied, dass ein ``PriorityMessage``-Objekt erzeugt wird.|
| Methode ``receive`` | ``Message receive (String name);`` <br/> Pro Aufruf der ``receive``-Methode wird einem Empfänger (mit Namen ``name``) eine Nachricht zugestellt. Die Nachricht muss im ``MessageQueue``-Unterobjekt abgelegt sein. Liegt für den Empfänger keine Nachricht vor, liefert die Methode den Wert ``null`` zurück.|
| Methode ``receiveAllMessages`` | ``List<Message> receiveAllMessages(String name);`` <br/> Ein Aufruf der ``receiveAllMessages``-Methode liedert alle Nachrichten zurück, die dem Empfänger (mit Namen ``name``) zugestellt sind.|

Tabelle 3. Zentrale Elemente der Klasse ``Messenger``.

Es folgen mehrere Testbeispiele, um die einzelnen Funktionalitäten der ``Messenger``-Klasse aufzuzeigen:

*Testrahmen* 1: Versenden und Empfangen von normalen Nachrichten

```dart
void testMessenger() {
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
```

*Ausgabe*:

```
Sending: From: Franz, To: Susan, Text: [First Message]
Sending: From: Franz, To: Susan, Text: [Second Message]
Received:
Regular  Message --> Sender: Franz, Recipient: Susan, Text: First Message
Received: 
Regular  Message --> Sender: Franz, Recipient: Susan, Text: Second Message
```

*Testrahmen* 2: Versenden und Empfangen von sowohl normalen Nachrichten als auch Nachrichten mit Priorität

```dart
void testMessenger() {
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
```

*Ausgabe*:

```
Priority Message ==> Sender: Franz, Recipient: Susan, Text: 2. Message
Priority Message ==> Sender: Franz, Recipient: Susan, Text: 4. Message
Priority Message ==> Sender: Franz, Recipient: Susan, Text: 6. Message
Priority Message ==> Sender: Franz, Recipient: Susan, Text: 8. Message
Regular  Message --> Sender: Franz, Recipient: Susan, Text: 1. Message
Regular  Message --> Sender: Franz, Recipient: Susan, Text: 3. Message
Regular  Message --> Sender: Franz, Recipient: Susan, Text: 5. Message
Regular  Message --> Sender: Franz, Recipient: Susan, Text: 7. Message
```

*Testrahmen* 3: Test der Methode ``receiveAllMessages``):

```dart
void testMessenger() {
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
```

*Ausgabe*:

```
Received: Priority Message ==> Sender: Franz, Recipient: Sepp, Text: 4. Message
Received: Priority Message ==> Sender: Franz, Recipient: Sepp, Text: 8. Message
Received: Regular  Message --> Sender: Franz, Recipient: Sepp, Text: 2. Message
Received: Regular  Message --> Sender: Franz, Recipient: Sepp, Text: 6. Message
```
