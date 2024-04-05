
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopease_app/data/datasources/address_remote_datasource.dart';
import 'package:shopease_app/data/models/response/address_response_model.dart';

part 'address_event.dart';
part 'address_state.dart';
part 'address_bloc.freezed.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(const _Initial()) {
    on<AddressEvent>((event, emit) async {
      emit(const _Loading());
      final result = await AddressRemoteDatasource().getAddress();
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
