// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileEntity _$FileEntityFromJson(Map<String, dynamic> json) => FileEntity(
      fid: json['fid'] as int?,
      uuid: json['uuid'] as String?,
      uid: json['uid'] as int?,
      langcode: json['langcode'] as String?,
      filename: json['filename'] as String?,
      url: json['url'] as String?,
      filemime: json['filemime'] as String?,
      filesize: json['filesize'] as String?,
      created: json['created'] as String?,
      changed: json['changed'] as String?,
    );

Map<String, dynamic> _$FileEntityToJson(FileEntity instance) =>
    <String, dynamic>{
      'fid': instance.fid,
      'uuid': instance.uuid,
      'uid': instance.uid,
      'langcode': instance.langcode,
      'filename': instance.filename,
      'url': instance.url,
      'filemime': instance.filemime,
      'filesize': instance.filesize,
      'created': instance.created,
      'changed': instance.changed,
    };
