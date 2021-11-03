import 'package:equatable/equatable.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';

abstract class FolderDialogState extends Equatable {}

class FolderDialogInitialState extends FolderDialogState {
  @override
  List<Object> get props => <Object>[];
}

class GetFoldersDialogLoadingState extends FolderDialogState {
  @override
  List<Object> get props => <Object>[];
}

class GetFoldersDialogSuccessState extends FolderDialogState {
  GetFoldersDialogSuccessState({required this.list});
  final List<FolderItem> list;
  @override
  List<Object> get props => <Object>[];
}

class GetFoldersDialogFailedState extends FolderDialogState {
  GetFoldersDialogFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}
