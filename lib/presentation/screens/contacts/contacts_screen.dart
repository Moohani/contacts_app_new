import 'package:contacts_app_new/bussines_logic/app_cubit.dart';
import 'package:contacts_app_new/presentation/views/contact_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var contacts = AppCubit.get(context).contacts;
        return ContactBuilder(
            contacts: contacts,
            noContacts: 'No Contacts yet..',
            contactType: 'all'
        );
      },
    );
  }
}
