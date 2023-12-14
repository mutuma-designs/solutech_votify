import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../elections/presentation/controllers/elections_controller.dart';
import '../../domain/entities/position.dart';
import '../../domain/usecases/add_position.dart';
import '../../domain/usecases/delete_position.dart';
import '../../domain/usecases/update_position.dart';
import '../states/position_state.dart';

class PositionController extends StateNotifier<PositionState> {
  AddPosition addPositionUseCase;
  UpdatePosition updatePositionUseCase;
  DeletePosition deletePositionUseCase;
  PositionController({
    required this.addPositionUseCase,
    required this.updatePositionUseCase,
    required this.deletePositionUseCase,
  }) : super(PositionInitial());

  void savePosition({
    required int electionId,
    required String name,
    required String description,
    required int maxSelections,
  }) async {
    state = PositionSaving();
    var response = await addPositionUseCase(AddPositionParams(
      electionId: electionId,
      name: name,
      description: description,
      maxSelections: maxSelections,
    ));
    await response.fold((failure) {
      state = AddingPositionFailed(failure);
    }, (success) async {
      state = PositionAdded();
    });
  }

  void updatePosition({
    required int positionId,
    required String name,
    required String description,
    required int maxSelections,
  }) {
    state = PositionSaving();
    updatePositionUseCase(UpdatePositionParams(
      positionId: positionId,
      name: name,
      description: description,
      maxSelections: maxSelections,
    )).then((response) async {
      await response.fold((failure) {
        state = UpdatingPositionFailed(failure);
      }, (success) async {
        state = PositionUpdated();
      });
    });
  }

  void deletePosition(int positionId) async {
    state = PositionDeleting();
    var response = await deletePositionUseCase(DeletePositionParams(
      positionId: positionId,
    ));
    await response.fold((failure) {
      state = DeletingPositionFailed(failure);
    }, (success) async {
      state = PositionDeleted();
    });
  }
}

final positionStateProvider =
    StateNotifierProvider.autoDispose<PositionController, PositionState>((ref) {
  AddPosition addPosition = ref.watch(addPositionUseCaseProvider);
  UpdatePosition updatePosition = ref.watch(updatePositionUseCaseProvider);
  DeletePosition deletePosition = ref.watch(deletePositionUseCaseProvider);

  return PositionController(
    addPositionUseCase: addPosition,
    updatePositionUseCase: updatePosition,
    deletePositionUseCase: deletePosition,
  );
});

final positionProvider = Provider.autoDispose.family<Position?, int>((ref, id) {
  final electionsState = ref.watch(electionsStateProvider);
  return electionsState.data
      .expand((element) => element.positions)
      .firstWhereOrNull(
        (element) => element.id == id,
      );
});
