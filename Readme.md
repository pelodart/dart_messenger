# Ein einfacher Nachrichten-Messenger in Dart

In dieser Aufgabe betrachten wir einen einfachen Nachrichten-Messenger im Sinne der bekannten Smartphone-Apps WhatsApp- oder Facebook-Messenger. Neben dem reinen Versenden von Nachrichten besitzt der Dart-Messenger auch eine Benutzerverwaltung. Beide Teilnehmer (Sender und Empfänger) müssen am Messenger registriert sein, bevor sie Nachrichten senden oder empfangen können.
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
```

*Ausgabe*:

```
UserRepository: 3 entries.
1: Franz
2: Hans
3: Sepp
```

## Klasse ``Message``

Nachrichten werden vom Messenger intern in Objekten des Typs ``Message`` verwaltet. Im Instanzdatenbereich
einer Nachricht sind drei Zeichenketten abzulegen:

*  Zeichenkette ``_sender`` – Name des Absenders. Muss in der Benutzerverwaltung vorhanden sein.
*  Zeichenkette ``_recipient`` – Name des Empfängers. Muss in der Benutzerverwaltung vorhanden sein.
*  Zeichenkette ``_text`` – Text der Nachricht. Eine Nachricht sollte beliebig lang sein können.

Implementieren Sie eine Klasse ``Message`` mit den drei Eigenschaften ``Sender``, ``Recipient`` und ``Text`` (*getter*- und *setter*- Methode).

*Hinweis*: Die Anforderung „Name muss in der Benutzerverwaltung vorhanden sein“ können Sie erst zu einem späteren Zeitpunkt in der Realisierung umsetzen.

Ferner besitzt die Klasse eine Methode ``recipientEquals``:

```
bool recipientEquals(String name);
```

Die Methode ``recipientEquals`` liefert ``true`` zurück, wenn der übergebene Parameter ``name`` gleich dem Empfängernamen in der Nachricht ist, andernfalls ``false``.

## Klasse ``MessageQueue``

Kernstück des Messengers ist die Klasse ``MessageQueue``. In einem Objekt dieses Typs werden alle Nachrichten abgelegt, die versendet werden – und zu einem späteren Zeitpunkt ihrem Empfänger zugestellt werden. Legen Sie in Ihrer Realisierung der Klasse ``MessageQueue`` eine array-ähnliche Datenstruktur zu Grunde, die ``Message``-Objekte aufnehmen kann. Mit den beiden Methoden ``addMessage`` und ``removeMessage`` (siehe Tabelle 2) lassen sich in einem ``MessageQueue``-Objekt Nachrichten ablegen und entfernen:

| Element | Schnittstelle und Beschreibung |
|:-|:-|
| Konstruktor | ``MessageQueue();``<br/> Legt ein leeres ``MessageQueue``-Objekt an.|
| *getter* ``Count`` | ``int get Count`` <br/> Liefert die Anzahl aller Nachrichten im ``MessageQueue``-Objekt zurück.|
| Methode ``addMessage`` | ``void addMessage(Message message);`` <br/> Legt im ``MessageQueue``-Objekt eine Nachricht ab.|
| Methode ``removeMessage`` | ``Message removeMessage (String name);`` <br/> Entfernt im ``MessageQueue``-Objekt eine Nachricht, deren Empfänger durch den Parameter ``name`` vorgegeben ist und liefert diese durch den Rückgabeparameter zurück. Liegt für den Empfänger ``name`` keine Nachricht vor, liefert die Methode den Wert ``null`` zurück.|
| Methode ``allMessagesForUser`` | ``List<Message> allMessagesForUser(String name);`` <br/> Liefert eine Liste mit allen Nachrichten zurück, die für den Empfänger ``name`` vorhanden sind. Die Nachrichten werden dabei im ``MessageQueue``-Objekt *nicht* gelöscht.|

Tabelle 2. Zentrale Elemente der Klasse ``MessageQueue``.

## Klasse ``MessengerService``

Mit den geleisteten Vorarbeiten sollte es nun ein Einfaches sein, die Realisierung der Klasse MessengerService
anzugehen. Diese besitzt für alle registrierten Benutzer und alle Nachrichten zwei Unterobjekte des Typs

*  ``UserRepository`` und
*  ``MessageQueue``

Alle Methoden der ``MessengerService``-Klasse, die sich auf die Verwaltung der Benutzer beziehen, sind folglich auf das ``UserRepository``-Unterobjekt abzubilden – und alle Methoden zum Senden und Empfangen von Nachrichten offensichtlich auf das ``MessageQueue``-Unterobjekt. Damit sollte eine Implementierung der Methoden aus Tabelle 3 keine Probleme mehr bereiten:

| Element | Schnittstelle und Beschreibung |
|:-|:-|
| Konstruktor | ``MessengerService();``<br/> Legt ein leeres ``MessengerService``-Objekt an.|
| Methode ``registerUser`` | ``bool registerUser(String name);`` <br/> Meldet einen Benutzer mit dem Benutzernamen ``name`` in der Benutzerverwaltung des Nachrichtendienstes an. Ist der Name bereits vergeben, liefert die Methode ``false`` zurück, andernfalls ``true``.|
| Methode ``unregisterUser`` | ``bool unregisterUser(String name);`` <br/> Meldet einen Benutzer mit dem Benutzernamen ``name`` in der Benutzerverwaltung des Nachrichtendienstes ab. Kann der Name nicht gefunden werden, liefert die Methode ``false`` zurück, andernfalls ``true``.|
| Methode ``send`` | ``bool send (String from, String to, String text);`` <br/> Sendet eine Nachricht ``text`` mit Absender ``from`` an den Empfänger ``to``. An Hand der Parameter wird ein ``Message``-Objekt angelegt und im ``MessageQueue``-Unterobjekt abgelegt. Sender und Empfänger müssen in der Benutzerverwaltung registriert sein.|
| Methode ``receive`` | ``Message receive (String name);`` <br/> Pro Aufruf der ``receive``-Methode wird einem Empfänger (mit Namen ``name``) eine Nachricht zugestellt. Die Nachricht muss im ``MessageQueue``-Unterobjekt abgelegt sein. Liegt für den Empfänger keine Nachricht vor, liefert die Methode den Wert ``null`` zurück.|

Tabelle 3. Zentrale Elemente der Klasse ``MessengerService``.

