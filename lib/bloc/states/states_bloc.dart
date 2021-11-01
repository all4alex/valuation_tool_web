import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/models/blackbook/state_response.dart';
import 'package:valuation_tool_web/models/firestore/note_item_model.dart';
import 'package:valuation_tool_web/repository/black_book_vehicle_repository.dart';

import 'states_state.dart';

class StatesBloc extends Cubit<StatesState> {
  StatesBloc() : super(StatesInitialState());

  BlackBookRepository _blackBookRepository = BlackBookRepositoryImpl();

  void getAllStates() async {
    emit(GetStatesLoadingState());
    try {
      StateResponse stateResponse = await _blackBookRepository.getStateList();
      final List<StateList>? stateList = stateResponse.states!.stateList;

      emit(GetStatesSuccessState(stateList: stateList));
    } catch (e) {
      emit(GetStatesFailedState(error: e.toString()));
    }
  }
}
