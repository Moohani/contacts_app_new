import 'package:contacts_app_new/presentation/styles/colors.dart';
import 'package:contacts_app_new/presentation/views/contacts_item.dart';
import 'package:contacts_app_new/presentation/views/favourite_item.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ContactBuilder extends StatelessWidget {

   ContactBuilder({
    Key? key,
    required this.contacts,
    required this.noContacts,
    required this.contactType,
  }
  ) : super(key: key);
   List<Map> contacts;
   String noContacts;
   String contactType;

  @override
  Widget build(BuildContext context) {
    return contacts.isEmpty
        ? ListView.separated(
        itemBuilder: (context,index){
          if (contactType == 'favourite') {
            return FavouriteItem(model: contacts[index]);
          }else{
            return ContactsItem(model: contacts[index]);
          }
        },
        separatorBuilder: (context,index) => Row(
          children: [
            Expanded(
                child: Divider(height: 1.h, color: white,)
            )
          ],
        ),
        itemCount: contacts.length,
    )
    : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(
            Icons.no_accounts,
            size: 75.sp,
             color: white,
          ),
          Text(noContacts,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: white),
          )
        ],
        
      ),
    );
  }
}
