// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu> - 
// See the AUTHORS file for other contributors.

import 'dart:io';

import 'package:logger/server.dart';
import 'package:convert/convert.dart';
import 'package:core/dataset_sop.dart';
import 'package:core/system.dart';

import 'package:deid/src/basic_profile.dart';
import 'package:deid/src/deidentifier.dart';

String testData = "C:/odw/sdk/convert/test_data/";
String testOutput = "C:/odw/sdk/convert/test_output/";

List pidMint10 = [
  "PID_MINT10", [
    "PID_MINT10/CR.2.16.840.1.114255.393386351.1568457295.17895.5.dcm",
    "PID_MINT10/CR.2.16.840.1.114255.393386351.1568457295.48879.7.dcm"
  ]
];
String crf1 = "PID_MINT10/CR.2.16.840.1.114255.393386351.1568457295.17895.5.dcm";
String crf2 = "PID_MINT10/CR.2.16.840.1.114255.393386351.1568457295.48879.7.dcm";

String output = "output.dcm";

void main() {
  Logger log = System.init(level: Level.config);
  String inPath = testData + crf1;

  File file = new File(inPath);
  log.config('Reading file: $file');
  var bytes = file.readAsBytesSync();
  DcmDecoder decoder = new DcmDecoder(bytes);
  print('decoder: $decoder');

  Instance instance = decoder.readSopInstance(inPath);
  var study = instance.study;
  print(study.summary);
  Format fmt = new Format(depth: -1);
  var s = fmt.study(study);
  print(s);

  //De-Identify
  DeIdentifier deid = new DeIdentifier();
  deid(instance);
  study = instance.study;
  print('main:study: $study');
  print(study.summary);
  fmt = new Format(depth: -1);
  s = fmt.study(study);
  print(s);
}