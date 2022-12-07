import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bussines_logic/app_cubit.dart';
import '../../views/contact_builder.dart';

class FavouriteScreens extends StatelessWidget {
  const FavouriteScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var contacts = AppCubit.get(context).favourite;
        return ContactBuilder(
            contacts: contacts,
            noContacts: 'No Favourite Contacts yet..',
            contactType: 'favourite'
        );
      },
    );
  }
}
