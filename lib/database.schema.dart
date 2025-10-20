// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint
// dart format off

import 'package:stormberry/migrate.dart';

final DatabaseSchema schema = DatabaseSchema.fromMap({
  "users": {
    "columns": {
      "id": {
        "type": "text"
      },
      "created_at": {
        "type": "timestamp"
      }
    },
    "constraints": [
      {
        "type": "primary_key",
        "column": "id"
      }
    ],
    "indexes": []
  },
  "posts": {
    "columns": {
      "id": {
        "type": "text"
      },
      "content": {
        "type": "text"
      },
      "created_at": {
        "type": "timestamp"
      },
      "user_id": {
        "type": "text",
        "isNullable": true
      }
    },
    "constraints": [
      {
        "type": "primary_key",
        "column": "id"
      },
      {
        "type": "foreign_key",
        "column": "user_id",
        "target": "users.id",
        "on_delete": "set_null",
        "on_update": "cascade"
      }
    ],
    "indexes": []
  }
});
