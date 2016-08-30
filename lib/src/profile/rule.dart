// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Original author: Jim Philbin <jfphilbin@gmail.edu> - 
// See the AUTHORS file for other contributors.

import 'dart:convert';

import 'package:core/new_base.dart';

import 'rule_type.dart';


const List<String> ruleNames = const [
  "@add",
  "@always",
  "@append",
  "@blank",
  "@contents",
  "@date",
  "@empty",
  "@encrypt",
  "@hash",
  "@hashuid",
  "@hashname",
  "@hashptid",
  "@incrementDate",
  "@initials",
  "@integer",
  "@keep",
  "@lookup",
  "@modifiyDate",
  "@param",
  "@privateattribute",
  "@process",
  "@remove",
  "@require",
  "@round",
  "@time",
  "@truncate"
];

String action = r"remove|keep|empty|skip|default|ignore";
final RegExp actionRE = new RegExp(action);

const String condition = r'exists|isblank|equals|contains|matches';
final RegExp conditionRE = new RegExp(condition);

const Map<String, int> conditionMap = const {
  "exists": 2,
  "isBlank": 2,
  "equals": 3,
  "contains": 3,
  "matches": 3
};

class Rule {
  int index;
  Tag targetTag;
  String keyword;
  String function;
  List<String> args;
  List<String> scripts;
  List suffix;
  bool isParsed;

  Rule(this.index, int target, this.keyword)
      : targetTag = Tag.lookup(target) {
    if ((targetTag == null) ||
        ((keyword != null) && (keyword != targetTag.keyword)))
      throw 'Invalid targetTag($target) or keyword($keyword)';
  }

  int get argLength => args.length;

  Tag get sourceTag {
    int val = int.parse(args[0], onError: (s) => null);
    return (val != null) ? Tag.lookup(val) : null;
  }


  bool get isValidArgs {
    String condition = args[1];
    int nArgsRequired = conditionMap[condition];
    if ((nArgsRequired == null) || (nArgsRequired != argLength))
      return false;
    return true;
  }

  Map<String, dynamic> get map => {
    "index": index,
    "target": targetTag,
    "keyword": keyword,
    "function": function,
    "args": args,
    "scripts": scripts,
  };

  String get json => JSON.encode(map);


  toString() => 'Rule: $function($args) $scripts';
}