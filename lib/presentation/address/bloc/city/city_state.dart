part of 'city_bloc.dart';

@freezed
class CityState with _$CityState {
  const factory CityState.initial() = _Initial;
  const factory CityState.loading() = _Loading;
  const factory CityState.loaded(CityResponseModel city) = _Loaded;
  const factory CityState.error(String message) = _Error;
}
