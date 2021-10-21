// GENERATED CODE - DO NOT MODIFY BY HAND

/// 该文件是json_serializable命令生成的，非开发者编写
part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    json['code'] as int,
    json['method'] as String,
    json['requestPrams'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'code': instance.code,
      'method': instance.method,
      'requestPrams': instance.requestPrams,
    };
