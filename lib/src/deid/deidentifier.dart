// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Original author: Jim Philbin <jfphilbin@gmail.edu> - 
// See the AUTHORS file for other contributors.


// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu> - 
// See the AUTHORS file for other contributors.

import 'package:core/tag_dataset.dart';
import 'package:core/tag_element.dart';
import 'package:deid/profile.dart';
import 'package:deid/src/dictionary/basic_profile.dart';
import 'package:deid/src/trial/trial.dart';
import 'package:system/system.dart';
import 'package:tag/tag.dart';
import 'package:uid/uid.dart';

import 'action.dart';

// In static frequency order
/*
Map<String, DeIdentifer> actions = {
  "X": remove,
  "U": replaceUid,
  "Z": zeroOrDummy,
  "XorD": XorD,
  "XorZ": XorZ,
  "XorZorD": XorZorD,
  "D": dummy,
  "ZorD": ZorD,
  "XorZorU": XorZorU,
  "K": retain,
  "C": clean,
  "A": addIfMissing
};
*/
// In static frequency order
/*
List<DeIdentifer> get actionsList => [
  remove,
  replaceUid,
  zeroOrDummy,
  XorD,
  XorZ,
  XorZorD,
  dummy,
  ZorD,
  XorZorU,
  retain,
  clean,
  addIfMissing
];
*/
final List<String> defaultStringValue =  ["Open DICOMweb DeIdentifier: Dummy Value"];

/// Dummy - replace with a non-zero length value that may be a dummy value and
/// consistent with the VR.
const List<int> basicProfileDummyTags = const [

];

/// Dummy - replace with a non-zero length value that may be a dummy value and
/// consistent with the VR.
const List<int> basicProfileNoValueTags = const [

];

const List<int> basicProfileKeepTags = const [

];

const List<int> basicProfileCleanTags = const [

];

const List<int> basicProfileReplaceUidTags = const [

];

const List<int> basicProfileRemoveTags = const [
  0x00001000, 0x00080024, 0x00080025, 0x00080034, 0x00080035, 0x00080081, 0x00080092,
  0x00080094, 0x00080096, 0x00080201, 0x00081030, 0x0008103e, 0x00081040, 0x00081048,
  0x00081049, 0x00081050, 0x00081052, 0x00081060, 0x00081062, 0x00081080, 0x00081084,
  0x00081120, 0x00082111, 0x00084000, 0x00100021, 0x00100032, 0x00100050, 0x00100101,
  0x00100102, 0x00101000, 0x00101001, 0x00101002, 0x00101005, 0x00101010, 0x00101020,
  0x00101030, 0x00101040, 0x00101050, 0x00101060, 0x00101080, 0x00101081, 0x00101090,
  0x00102000, 0x00102110, 0x00102150, 0x00102152, 0x00102154, 0x00102160, 0x00102180,
  0x001021a0, 0x001021b0, 0x001021c0, 0x001021d0, 0x001021f0, 0x00102297, 0x00102299,
  0x00104000, 0x00181004, 0x00181005, 0x00181007, 0x00181008, 0x00184000, 0x00189424,
  0x0018a003, 0x00203401, 0x00203404, 0x00203406, 0x00204000, 0x00209158, 0x00284000,
  0x00320012, 0x00321020, 0x00321021, 0x00321030, 0x00321032, 0x00321033, 0x00321070,
  0x00324000, 0x00380004, 0x00380010, 0x00380011, 0x0038001e, 0x00380020, 0x00380021,
  0x00380040, 0x00380050, 0x00380060, 0x00380061, 0x00380062, 0x00380300, 0x00380400,
  0x00380500, 0x00384000, 0x00400001, 0x00400002, 0x00400003, 0x00400004, 0x00400005,
  0x00400006, 0x00400007, 0x0040000b, 0x00400010, 0x00400011, 0x00400012, 0x00400241,
  0x00400242, 0x00400243, 0x00400244, 0x00400245, 0x00400250, 0x00400251, 0x00400253,
  0x00400254, 0x00400275, 0x00400280, 0x00400555, 0x00401001, 0x00401004, 0x00401005,
  0x00401010, 0x00401011, 0x00401102, 0x00401103, 0x00401400, 0x00402001, 0x00402008,
  0x00402009, 0x00402010, 0x00402400, 0x00403001, 0x00404025, 0x00404027, 0x00404028,
  0x00404030, 0x00404034, 0x00404035, 0x00404036, 0x00404037, 0x0040a027, 0x0040a078,
  0x0040a07a, 0x0040a07c, 0x0040a730, 0x00700086, 0x00880200, 0x00880904, 0x00880906,
  0x00880910, 0x00880912, 0x04000100, 0x04000402, 0x04000403, 0x04000404, 0x04000550,
  0x04000561, 0x20300020, 0x40000010, 0x40004000, 0x40080042, 0x40080102, 0x4008010a,
  0x4008010b, 0x4008010c, 0x40080111, 0x40080114, 0x40080115, 0x40080118, 0x40080119,
  0x4008011a, 0x40080202, 0x40080300, 0x40084000, 0xfffafffa, 0xfffcfffc // don't reformat
];

const List<int> basicProfileNoValueTags = const [

  ];




typedef bool DeIdentifer(TagDataset ds, int tag, Trial trial, List<String> values) ;

//TODO: add global rules
class DeIdentifier {
  Trial trial;


  //TODO: make this work on Study
  List<String> deIdStudyUid = [Uid.generateSecureUidString()];
  List<String> deIdSeriesUid = [Uid.generateSecureUidString()];
  List<String> deIdInstanceUid = [Uid.generateSecureUidString()];
  Map<int, List> valueMap;
  Map<String, Function> globalActions;
  Map<String, Function> elementActions;

  //DeIdentifier(this.trial, this.valueMap) {
  DeIdentifier(this.trial) {

    globalActions = {};
  }

  //List<String> getValues(Trial trial, List<String> values) {}

  TagDataset fmi(TagDataset fmi) {
    print('FMI: $fmi');
    replaceUid(fmi, kMediaStorageSOPInstanceUID, trial, deIdInstanceUid);
    return fmi;
  }

  TagDataset call(TagDataset ds) {

    // ** ds.retainTags.addAll(trial.retainTags);

    /* TODO
    globalActions.values.forEach((Function foo) {
      foo(ds);
    });
    */
    //replaceUids(ds);
    ds.removePrivate();


    List<BasicProfile> bpList = BasicProfile.map.values.toList(growable: false);

    for (BasicProfile bp in bpList) {
      Tag tag = bp.tag;

      if (tag == null) continue;
      int code = tag.code;
    //  print('begin: $a');
      //DeIdentifier f = actions[bp.action];
      switch (bp.name) {
        case "X":
          remove(ds, code, trial);
          break;
        case "U":
          print('U: tag=${tag.dcm}');
          replaceUid(ds, code, trial);
          break;
        case "Z":
          zeroOrDummy(ds, code, trial);
          break;
        case "XD":
          kXorD(ds, code, trial);
          break;
        case "XZ":
          kXorZ(ds, code, trial);
          break;
        case "XZD":
          kXorZorD(ds, code, trial);
          break;
        case "D":
          dummy(ds, code, trial);
          break;
        case "ZD":
          kZorD(ds, code, trial);
          break;
        case "XZU":
          kXorZorU(ds, code, trial);
          break;
        case "K":
          retain(ds, tag, trial);
          break;
        case "C":
          clean(ds, code, trial);
          break;
      // case "A":
      //   addIfMissing(ds, code, trial);
      //   break;
        default:
          throw new InvalidActionError(bp.action);
      }
    //  print('end $a');
    }
    return ds;
  }

  bool remove(TagDataset ds, int tag, Trial trial, [List values]) {
    Element a = ds[tag];
    if (a == null) return false;
    if (a is SQ) return removeSequence(a, tag, trial);
    ds.remove(tag);
    return true;
  }

  bool removeSequence(SQ sq, int tag, Trial trial) {
    if ((sq.items != null) || (sq.items.length != 0)) {
      for (TagItem item in sq.items) {
        call(item);
      }
    }
    return true;
  }

  TagElement replaceUid(TagDataset ds, int code, Trial trial, [List values]) {
    print('DS: $ds, tag: ${Tag.toDcm(code)}, values=$values');
    Tag tag = PTag.lookupByCode(code);
    if (tag.vr != VR.kUI) return null;
    switch (code) {
      case kStudyInstanceUID:
        print('seriesUid: $deIdStudyUid');
        return ds.replaceUidsByCode(code, deIdStudyUid);
      case kSeriesInstanceUID:
        print('seriesUid: $deIdSeriesUid');
        return ds.replaceUidsByCode(code, deIdSeriesUid);
      case kSOPInstanceUID:
        print('instanceUid: $deIdInstanceUid');
        return ds.replaceUidsByCode(code, deIdInstanceUid);
      case kMediaStorageSOPInstanceUID:
        print('MediaStorageUid: $deIdInstanceUid');
        return ds.replaceUidsByCode(code, deIdInstanceUid);
      default:
      //TODO: what other Uids have to be replace
        ds.replaceUidsByCode(code, values);
    }
    print(' replaceUidsByCode: tag${Tag.toDcm(code)} values=$values');
    return ds.replaceUidsByCode(code, values);
  }

  void retain(TagDataset ds, Tag tag, Trial trial, [List values ]) =>
      ds.retain(tag);

  TagElement dummy(TagDataset ds, int code, Trial trial, [List values ]) =>
      ds.replaceCode(code, values);

  TagElement zeroOrDummy(TagDataset ds, int code, Trial trial, [List values ]) {
    //TODO: fix when we know ATypes
    return ds.replaceCode(code, values);
  }

  TagElement clean(TagDataset ds, int tag, Trial trial, [List values ]) {
    return ds.replaceCode(tag, values);
  }

  TagElement kZorD(TagDataset ds, int tag, Trial trial, [List values ]) {
    //TODO: fix when we know ATypes
    return dummy(ds, tag, trial, values);
  }

  TagElement kXorZ(TagDataset ds, int tag, Trial trial, [List values ]) {
    //TODO: fix when we know ATypes
    return zeroOrDummy(ds, tag, trial, values);
  }

  TagElement kXorD(TagDataset ds, int tag, Trial trial, [List values ]) {
    //TODO: fix when we know ATypes
    return dummy(ds, tag, trial, values);
  }

  TagElement kXorZorD(TagDataset ds, int tag, Trial trial, [List values ]) {
    //TODO: fix when we know ATypes
    return dummy(ds, tag, trial, values);
  }

  TagElement kXorZorU(TagDataset ds, int code, Trial trial, [List values ]) {
    //TODO: fix when we know ATypes
    // return  ds.replaceUidsByCode(code, values, trial);
    return  ds.replaceUidsByCode(code, values);
  }

  bool addIfMissing(TagDataset ds, List<String> values) {
    //TODO: finish
    return false;
  }
}

const Map map = const {
  "BasicProfile": const {
    "retain": const [],
    "remove": const [0x00001000, 0x00080024, 0x00080025, 0x00080034, 0x00080035, 0x00080081, 0x00080092, 0x00080094, 0x00080096, 0x00080201, 0x00081030, 0x0008103e, 0x00081040, 0x00081048, 0x00081049, 0x00081050, 0x00081052, 0x00081060, 0x00081062, 0x00081080, 0x00081084, 0x00081120, 0x00082111, 0x00084000, 0x00100021, 0x00100032, 0x00100050, 0x00100101, 0x00100102, 0x00101000, 0x00101001, 0x00101002, 0x00101005, 0x00101010, 0x00101020, 0x00101030, 0x00101040, 0x00101050, 0x00101060, 0x00101080, 0x00101081, 0x00101090, 0x00102000, 0x00102110, 0x00102150, 0x00102152, 0x00102154, 0x00102160, 0x00102180, 0x001021a0, 0x001021b0, 0x001021c0, 0x001021d0, 0x001021f0, 0x00102297, 0x00102299, 0x00104000, 0x00181004, 0x00181005, 0x00181007, 0x00181008, 0x00184000, 0x00189424, 0x0018a003, 0x00203401, 0x00203404, 0x00203406, 0x00204000, 0x00209158, 0x00284000, 0x00320012, 0x00321020, 0x00321021, 0x00321030, 0x00321032, 0x00321033, 0x00321070, 0x00324000, 0x00380004, 0x00380010, 0x00380011, 0x0038001e, 0x00380020, 0x00380021, 0x00380040, 0x00380050, 0x00380060, 0x00380061, 0x00380062, 0x00380300, 0x00380400, 0x00380500, 0x00384000, 0x00400001, 0x00400002, 0x00400003, 0x00400004, 0x00400005, 0x00400006, 0x00400007, 0x0040000b, 0x00400010, 0x00400011, 0x00400012, 0x00400241, 0x00400242, 0x00400243, 0x00400244, 0x00400245, 0x00400250, 0x00400251, 0x00400253, 0x00400254, 0x00400275, 0x00400280, 0x00400555, 0x00401001, 0x00401004, 0x00401005, 0x00401010, 0x00401011, 0x00401102, 0x00401103, 0x00401400, 0x00402001, 0x00402008, 0x00402009, 0x00402010, 0x00402400, 0x00403001, 0x00404025, 0x00404027, 0x00404028, 0x00404030, 0x00404034, 0x00404035, 0x00404036, 0x00404037, 0x0040a027, 0x0040a078, 0x0040a07a, 0x0040a07c, 0x0040a730, 0x00700086, 0x00880200, 0x00880904, 0x00880906, 0x00880910, 0x00880912, 0x04000100, 0x04000402, 0x04000403, 0x04000404, 0x04000550, 0x04000561, 0x20300020, 0x40000010, 0x40004000, 0x40080042, 0x40080102, 0x4008010a, 0x4008010b, 0x4008010c, 0x40080111, 0x40080114, 0x40080115, 0x40080118, 0x40080119, 0x4008011a, 0x40080202, 0x40080300, 0x40084000, 0xfffafffa, 0xfffcfffc]
  },
  "RetainSafePrivate": const {
    "retain": const [],
    "remove": const []
  },
  "RetainUids": const {
    "retain": const [0x00001000, 0x00001001, 0x00020003, 0x00041511, 0x00080014, 0x00080018, 0x00080058, 0x0008010d, 0x00081110, 0x00081111, 0x00081140, 0x00081155, 0x00081195, 0x00082112, 0x00083010, 0x00089123, 0x00181002, 0x0020000d, 0x0020000e, 0x00200052, 0x00200200, 0x00209161, 0x00209164, 0x00281199, 0x00281214, 0x00404023, 0x0040db0c, 0x0040db0d, 0x0070031a, 0x00880140, 0x30060024, 0x300600c2, 0x300a0013],
    "remove": const [0x00081120]
  },
  "RetainDeviceIdentity": const {
    "retain": const [0x00081010, 0x00181000, 0x00181002, 0x00181004, 0x00181005, 0x00181007, 0x00181008, 0x0018700a, 0x00321020, 0x00321021, 0x00400001, 0x00400010, 0x00400011, 0x00400241, 0x00400242, 0x00404025, 0x00404027, 0x00404028, 0x00404030],
    "remove": const []
  },
  "RetainPatientCharacteristics": const {
    "retain": const [0x00100040, 0x00101010, 0x00101020, 0x00101030, 0x00102160, 0x001021a0, 0x001021c0, 0x00102203],
    "remove": const [0x00102110, 0x00380050, 0x00380500, 0x00400012]
  },
  "RetainLongFullDates": const {
    "retain": const [0x00080020, 0x00080021, 0x00080022, 0x00080023, 0x00080024, 0x00080025, 0x0008002a, 0x00080030, 0x00080031, 0x00080032, 0x00080033, 0x00080034, 0x00080035, 0x00080201, 0x001021d0, 0x00380020, 0x00380021, 0x00400002, 0x00400003, 0x00400004, 0x00400005, 0x00400244, 0x00400245, 0x00400250, 0x00400251],
    "remove": const []
  },
  "RetainLongModifiedDates": const {
    "retain": const [],
    "remove": const [0x00080020, 0x00080021, 0x00080022, 0x00080023, 0x00080024, 0x00080025, 0x0008002a, 0x00080030, 0x00080031, 0x00080032, 0x00080033, 0x00080034, 0x00080035, 0x00080201, 0x001021d0, 0x00380020, 0x00380021, 0x00400002, 0x00400003, 0x00400004, 0x00400005, 0x00400244, 0x00400245, 0x00400250, 0x00400251]
  },
  "CleanDescriptors": const {
    "retain": const [],
    "remove": const [0x00081030, 0x0008103e, 0x00081080, 0x00081084, 0x00082111, 0x00084000, 0x00102000, 0x00102110, 0x00102180, 0x001021b0, 0x00104000, 0x00180010, 0x00181030, 0x00181400, 0x00184000, 0x00189424, 0x0018a003, 0x00204000, 0x00209158, 0x00321030, 0x00321060, 0x00321070, 0x00324000, 0x00380040, 0x00380062, 0x00380500, 0x00384000, 0x00400007, 0x00400254, 0x00400275, 0x00400280, 0x00401400, 0x00402001, 0x00402400, 0x4008010b, 0x40080115, 0x40080300, 0x40084000]
  },
  "CleanStructucturedContent": const {
    "retain": const [],
    "remove": const [0x00400555, 0x0040a730]
  },
  "CleanGraphics": const {
    "retain": const [],
    "remove": const [0x00700001]
  }
};

class InvalidActionError extends Error {
  Action action;
  String msg;

  InvalidActionError(this.action, [this.msg = "Invalid Action Error"]);

  @override
  String toString() => '$msg: $action';
}