part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}
class AppChangeBNBState extends AppState {}
class AppChangeBSState extends AppState {}
class AppCreateDataBaseState extends AppState {}
class AppGetDataBaseLoadingState extends AppState {}
class AppGetDataBaseState extends AppState {}
class AppInsertContactState extends AppState {}
class AppAddOrRemoveFavouriteContactState extends AppState {}
class AppEditContactState extends AppState {}
class AppDeleteContactsState extends AppState {}
