import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/election.dart';
import '../../domain/usecases/add_election.dart';
import '../../domain/usecases/delete_election.dart';
import '../../domain/usecases/end_election.dart';
import '../../domain/usecases/get_elections.dart';
import '../../domain/usecases/start_election.dart';
import '../../domain/usecases/update_election.dart';

enum ElectionsStatus {
  initial,
  loading,
  loaded,
  empty,
  loadingFailed,
  adding,
  updating,
  deleting,
  starting,
  ending,
  added,
  updated,
  deleted,
  started,
  ended,
  addingFailed,
  updatingFailed,
  deletingFailed,
  startingFailed,
  endingFailed,
}

typedef ElectionsState = ListState<Election, ElectionsStatus>;

class ElectionsController extends Notifier<ElectionsState> {
  @override
  build() {
    var getElectionsUseCase = ref.read(getElectionsUseCaseProvider);
    getElectionsUseCase();
    return ElectionsState.initial(ElectionsStatus.initial);
  }

  void addElection(AddElectionParams params) async {
    state = state.copyWith(
      status: ElectionsStatus.adding,
    );

    var addElectionUseCase = ref.read(addElectionUseCaseProvider);
    var response = await addElectionUseCase(params);

    response.fold((failure) {
      state = state.copyWith(
        status: ElectionsStatus.addingFailed,
        failure: failure,
      );
    }, (success) {
      state = state.copyWith(
        status: ElectionsStatus.added,
      );
      getElections();
    });
  }

  void updateElection(UpdateElectionParams params) async {
    state = state.copyWith(status: ElectionsStatus.updating);

    var updateElectionUseCase = ref.read(updateElectionUseCaseProvider);
    var response = await updateElectionUseCase(params);

    response.fold((failure) {
      state = state.copyWith(
        status: ElectionsStatus.updatingFailed,
        failure: failure,
      );
    }, (success) {
      state = state.copyWith(
        status: ElectionsStatus.updated,
      );
      getElections();
    });
  }

  void deleteElection(DeleteElectionParams params) async {
    state = state.copyWith(status: ElectionsStatus.deleting);

    var deleteElectionUseCase = ref.read(deleteElectionUseCaseProvider);
    var response = await deleteElectionUseCase(params);

    response.fold((failure) {
      state = state.copyWith(
        status: ElectionsStatus.deletingFailed,
        failure: failure,
      );
    }, (success) {
      state = state.copyWith(status: ElectionsStatus.deleted);
      getElections();
    });
  }

  void startElection(StartElectionParams params) async {
    state = state.copyWith(status: ElectionsStatus.starting);

    var startElectionUseCase = ref.read(startElectionUseCaseProvider);
    var response = await startElectionUseCase(params);

    response.fold((failure) {
      state = state.copyWith(
        status: ElectionsStatus.startingFailed,
        failure: failure,
      );
    }, (success) {
      state = state.copyWith(
        status: ElectionsStatus.started,
      );
      getElections();
    });
  }

  void endElection(EndElectionParams params) async {
    state = state.copyWith(status: ElectionsStatus.ending);

    var endElectionUseCase = ref.read(endElectionUseCaseProvider);
    var response = await endElectionUseCase(params);

    response.fold((failure) {
      state = state.copyWith(
        status: ElectionsStatus.endingFailed,
        failure: failure,
      );
    }, (success) {
      state = state.copyWith(
        status: ElectionsStatus.ended,
      );
      getElections();
    });
  }

  void getElections() async {
    state = state.copyWith(status: ElectionsStatus.loading);

    var getElectionsUseCase = ref.read(getElectionsUseCaseProvider);
    var response = await getElectionsUseCase();

    response.fold((failure) {
      state = state.copyWith(
        status: ElectionsStatus.loadingFailed,
        failure: failure,
      );
    }, (elections) {
      state = state.copyWith(
        status: ElectionsStatus.loaded,
        data: elections,
      );
    });
  }
}

final electionsStateProvider =
    NotifierProvider.autoDispose<ElectionsController, ElectionsState>(
  () => ElectionsController(),
);

final electionProvider = Provider.autoDispose.family<Election?, int>((ref, id) {
  final electionsState = ref.watch(electionsStateProvider);
  final elections = electionsState.data;
  return elections.firstWhereOrNull(
    (element) => element.id == id,
  );
});
