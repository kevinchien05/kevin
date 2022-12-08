import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  var _contacts;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    List<Contact> contacts = await ContactsService.getContacts();
    print(contacts);
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: _contacts != null && _contacts.length != 0
          ? ListView.builder(
              itemCount: _contacts?.length ?? 0,
              itemBuilder: (context, int index) {
                Contact? contact = _contacts?.elementAt(index);
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  leading:
                      (contact?.avatar != null && contact!.avatar!.isNotEmpty)
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(
                                contact.avatar!,
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Text(contact!.initials()),
                            ),
                  title: Text(contact.displayName ?? ""),
                );
              })
          : Center(child: Text('Kontak Kosong')),
    );
  }
}
