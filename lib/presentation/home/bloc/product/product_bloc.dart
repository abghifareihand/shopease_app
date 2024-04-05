import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopease_app/data/datasources/product_remote_datasource.dart';
import 'package:shopease_app/data/models/response/product_response_model.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  int page = 1;
  ProductBloc() : super(const _Initial()) {
    on<_GetProducts>((event, emit) async {
      emit(const _Loading());
      final result = await ProductRemoteDatasource().getProducts();
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });

    // on<_LoadMoreProducts>((event, emit) async {
    //   emit(const _Loading());
    //   final result = await ProductRemoteDatasource().getProductPagination(page);
    //   result.fold(
    //     (error) => emit(_Error(error)),
    //    (data) {
    //       page++;
    //       emit(_Loaded(data));
    //     },
    //   );
    // });
  }
}
