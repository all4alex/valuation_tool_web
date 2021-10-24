import 'package:equatable/equatable.dart';

abstract class AddToFolderState extends Equatable {}

class AddToFolderInitialState extends AddToFolderState {
  @override
  List<Object> get props => <Object>[];
}

class AddToFolderLoadingState extends AddToFolderState {
  @override
  List<Object> get props => <Object>[];
}

class AddToFolderSuccessState extends AddToFolderState {
  AddToFolderSuccessState({required this.folderName});
  final String folderName;
  @override
  List<Object> get props => <Object>[];
}

class AddToFolderFailedState extends AddToFolderState {
  AddToFolderFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}
