import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProfileExtra extends Equatable {
  const ProfileExtra({this.data, this.meta});

  factory ProfileExtra.fromMap(Map<String, dynamic> map) {
    return ProfileExtra(
      data: map['data'] == null ? null : DataProfileExtra.fromMap(map['data']),
      meta: map['meta'] == null ? null : MetaProfileExtra.fromMap(map['meta']),
    );
  }

  factory ProfileExtra.fromJson(String source) =>
      ProfileExtra.fromMap(json.decode(source));

  final DataProfileExtra? data;
  final MetaProfileExtra? meta;

  Map<String, dynamic> toMap() {
    return {'data': data?.toMap(), 'meta': meta?.toMap()};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [data, meta];
}

class DataProfileExtra extends Equatable {
  const DataProfileExtra({
    this.avatarUrl,
    this.companyId,
    this.createdAt,
    this.division,
    this.email,
    this.fullName,
    this.id,
    this.nip,
    this.role,
    this.updatedAt,
  });

  factory DataProfileExtra.fromMap(Map<String, dynamic> map) {
    return DataProfileExtra(
      avatarUrl: map['avatar_url'],
      companyId: int.tryParse(map['company_id']?.toString() ?? ''),
      createdAt: map['created_at'],
      division: map['division'],
      email: map['email'],
      fullName: map['full_name'],
      id: int.tryParse(map['id']?.toString() ?? ''),
      nip: map['nip'],
      role: map['role'],
      updatedAt: map['updated_at'],
    );
  }

  factory DataProfileExtra.fromJson(String source) =>
      DataProfileExtra.fromMap(json.decode(source));

  final String? avatarUrl;
  final int? companyId;
  final String? createdAt;
  final String? division;
  final String? email;
  final String? fullName;
  final int? id;
  final String? nip;
  final String? role;
  final String? updatedAt;

  Map<String, dynamic> toMap() {
    return {
      'avatar_url': avatarUrl,
      'company_id': companyId,
      'created_at': createdAt,
      'division': division,
      'email': email,
      'full_name': fullName,
      'id': id,
      'nip': nip,
      'role': role,
      'updated_at': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [
    avatarUrl,
    companyId,
    createdAt,
    division,
    email,
    fullName,
    id,
    nip,
    role,
    updatedAt,
  ];
}

class MetaProfileExtra extends Equatable {
  const MetaProfileExtra({this.code, this.message, this.status});

  factory MetaProfileExtra.fromMap(Map<String, dynamic> map) {
    return MetaProfileExtra(
      code: int.tryParse(map['code']?.toString() ?? ''),
      message: map['message'],
      status: map['status'],
    );
  }

  factory MetaProfileExtra.fromJson(String source) =>
      MetaProfileExtra.fromMap(json.decode(source));

  final int? code;
  final String? message;
  final String? status;

  Map<String, dynamic> toMap() {
    return {'code': code, 'message': message, 'status': status};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [code, message, status];
}
