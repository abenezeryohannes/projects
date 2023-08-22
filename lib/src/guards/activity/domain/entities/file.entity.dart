import 'package:json_annotation/json_annotation.dart';
part 'file.entity.g.dart';

@JsonSerializable()
class FileEntity {
  int? fid;
  String? uuid;
  int? uid;
  String? langcode;
  String? filename;
  String? url;
  String? filemime;
  String? filesize;
  String? created;
  String? changed;

  FileEntity(
      {this.fid,
      this.uuid,
      this.uid,
      this.langcode,
      this.filename,
      this.url,
      this.filemime,
      this.filesize,
      this.created,
      this.changed});

  factory FileEntity.fromJson(Map<String, dynamic> json) =>
      _$FileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FileEntityToJson(this);
  //
  //
  //
}
