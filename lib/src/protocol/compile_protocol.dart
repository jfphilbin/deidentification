// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu> - 
// See the AUTHORS file for other contributors.

import 'package:core/new_base.dart';
import 'package:deid/protocol.dart';

class ProtocolCompiler {
  Protocol protocol;
  Map<String, String> trial;

  ProtocolCompiler(this.protocol, this.trial);

  List<Rule> get rules => protocol.rules;



  String lookup(String param) {
    if (param[0] != '@') return param;
    String value = trial[param];
    return (value != null) ? value : protocol.pMap[param];
  }


  String generate() {
    for (int i = 0; i < rules.length; i++) {
      switch (protocol.rules[i].function) {
        case "@param":
          param(rule);
      }

    }
  }
  String blanks(rule) {
    Tag t = rule.tag;
    Element e = elements[tag];
    if (e.vr.type == "String")
      throw "invalid Rule";
    String arg = lookup(rule.args[0]);
    int n = int.parse(arg);
    String spaces = "".padRight(n, " ");
    return '''(Dataset ds) {
    ${e.vr} a = ds.lookup(${rule.targetTag});
    return a.replace([$spaces]);
  }''';

    String param(Rule rule) {

    }
  }

}