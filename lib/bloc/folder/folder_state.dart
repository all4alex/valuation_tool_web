import 'package:equatable/equatable.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';

abstract class FolderState extends Equatable {}

class FolderInitialState extends FolderState {
  @override
  List<Object> get props => <Object>[];
}

class GetFoldersLoadingState extends FolderState {
  @override
  List<Object> get props => <Object>[];
}

class GetFoldersSuccessState extends FolderState {
  GetFoldersSuccessState({required this.list});
  final List<FolderItem> list;
  @override
  List<Object> get props => <Object>[];
}

class GetFoldersFailedState extends FolderState {
  GetFoldersFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class AddFolderLoadingState extends FolderState {
  @override
  List<Object> get props => <Object>[];
}

//for dialogs
class GetFoldersFromDialogLoadingState extends FolderState {
  @override
  List<Object> get props => <Object>[];
}

class GetFoldersFromDialogSuccessState extends FolderState {
  GetFoldersFromDialogSuccessState({required this.list});
  final List<FolderItem> list;
  @override
  List<Object> get props => <Object>[];
}

class GetFoldersFromDialogFailedState extends FolderState {
  GetFoldersFromDialogFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class AddFolderSuccessState extends FolderState {
  AddFolderSuccessState();
  @override
  List<Object> get props => <Object>[];
}

class AddFolderFailedState extends FolderState {
  AddFolderFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class DeleteFolderLoadingState extends FolderState {
  @override
  List<Object> get props => <Object>[];
}

class DeleteFolderSuccessState extends FolderState {
  DeleteFolderSuccessState();
  @override
  List<Object> get props => <Object>[];
}

class DeleteFolderFailedState extends FolderState {
  DeleteFolderFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}
