// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Failure _$FailureFromJson(Map<String, dynamic> json) => Failure(
      message: json['message'] as String?,
      failureType:
          $enumDecodeNullable(_$FailureTypeEnumMap, json['failureType']) ??
              FailureType.GENERAL,
    )..error = json['error'] as bool?;

Map<String, dynamic> _$FailureToJson(Failure instance) => <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'failureType': _$FailureTypeEnumMap[instance.failureType],
    };

const _$FailureTypeEnumMap = {
  FailureType.DATABASE: 'DATABASE',
  FailureType.SERVER: 'SERVER',
  FailureType.INTERNET: 'INTERNET',
  FailureType.FORMAT: 'FORMAT',
  FailureType.GENERAL: 'GENERAL',
};
