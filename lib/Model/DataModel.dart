import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'DataModel.g.dart';

@JsonSerializable()
class DataModel extends Equatable {
  final String id;
  final String createdAt;
  final String name;
  final String avatar;
  DataModel({this.id, this.createdAt, this.name, this.avatar});
  @override
  List<Object> get props => [id, createdAt, name, avatar];
  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);
  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}
