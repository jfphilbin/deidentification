// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu> -
// See the AUTHORS file for other contributors.

// *** This file generated by '../bin/generate/generate_basic_profile.dart' ***
// ----------------------------------------------------------

import 'package:deid/src/deid/action.dart';

class RetainDeviceIdentityOption {
  final int tag;
  final String keyword;
  final Action action;

  const RetainDeviceIdentityOption(this.tag, this.keyword, this.action);

  static lookup(int tag) => map[tag];

  static const kCassetteID = const RetainDeviceIdentityOption(0x00181007, "CassetteID", Action.K);
  static const kDetectorID = const RetainDeviceIdentityOption(0x0018700A, "DetectorID", Action.K);
  static const kDeviceSerialNumber = const RetainDeviceIdentityOption(0x00181000, "DeviceSerialNumber", Action.K);
  static const kDeviceUID = const RetainDeviceIdentityOption(0x00181002, "DeviceUID", Action.K);
  static const kGantryID = const RetainDeviceIdentityOption(0x00181008, "GantryID", Action.K);
  static const kGeneratorID = const RetainDeviceIdentityOption(0x00181005, "GeneratorID", Action.K);
  static const kPerformedStationAETitle = const RetainDeviceIdentityOption(0x00400241, "PerformedStationAETitle", Action.K);
  static const kPerformedStationGeographicLocationCodeSequence = const RetainDeviceIdentityOption(0x00404030, "PerformedStationGeographicLocationCodeSequence", Action.K);
  static const kPerformedStationName = const RetainDeviceIdentityOption(0x00400242, "PerformedStationName", Action.K);
  static const kPerformedStationNameCodeSequence = const RetainDeviceIdentityOption(0x00404028, "PerformedStationNameCodeSequence", Action.K);
  static const kPlateID = const RetainDeviceIdentityOption(0x00181004, "PlateID", Action.K);
  static const kScheduledProcedureStepLocation = const RetainDeviceIdentityOption(0x00400011, "ScheduledProcedureStepLocation", Action.K);
  static const kScheduledStationAETitle = const RetainDeviceIdentityOption(0x00400001, "ScheduledStationAETitle", Action.K);
  static const kScheduledStationGeographicLocationCodeSequence = const RetainDeviceIdentityOption(0x00404027, "ScheduledStationGeographicLocationCodeSequence", Action.K);
  static const kScheduledStationName = const RetainDeviceIdentityOption(0x00400010, "ScheduledStationName", Action.K);
  static const kScheduledStationNameCodeSequence = const RetainDeviceIdentityOption(0x00404025, "ScheduledStationNameCodeSequence", Action.K);
  static const kScheduledStudyLocation = const RetainDeviceIdentityOption(0x00321020, "ScheduledStudyLocation", Action.K);
  static const kScheduledStudyLocationAETitle = const RetainDeviceIdentityOption(0x00321021, "ScheduledStudyLocationAETitle", Action.K);
  static const kStationName = const RetainDeviceIdentityOption(0x00081010, "StationName", Action.K);


  static const Map<int, String> map = const {
    0x00181007: kCassetteID,
    0x0018700A: kDetectorID,
    0x00181000: kDeviceSerialNumber,
    0x00181002: kDeviceUID,
    0x00181008: kGantryID,
    0x00181005: kGeneratorID,
    0x00400241: kPerformedStationAETitle,
    0x00404030: kPerformedStationGeographicLocationCodeSequence,
    0x00400242: kPerformedStationName,
    0x00404028: kPerformedStationNameCodeSequence,
    0x00181004: kPlateID,
    0x00400011: kScheduledProcedureStepLocation,
    0x00400001: kScheduledStationAETitle,
    0x00404027: kScheduledStationGeographicLocationCodeSequence,
    0x00400010: kScheduledStationName,
    0x00404025: kScheduledStationNameCodeSequence,
    0x00321020: kScheduledStudyLocation,
    0x00321021: kScheduledStudyLocationAETitle,
    0x00081010: kStationName};

  static const List<int> keys = const [
    0x00181007,
    0x0018700A,
    0x00181000,
    0x00181002,
    0x00181008,
    0x00181005,
    0x00400241,
    0x00404030,
    0x00400242,
    0x00404028,
    0x00181004,
    0x00400011,
    0x00400001,
    0x00404027,
    0x00400010,
    0x00404025,
    0x00321020,
    0x00321021,
    0x00081010];

  static const List<String> values = const [
    kCassetteID,
    kDetectorID,
    kDeviceSerialNumber,
    kDeviceUID,
    kGantryID,
    kGeneratorID,
    kPerformedStationAETitle,
    kPerformedStationGeographicLocationCodeSequence,
    kPerformedStationName,
    kPerformedStationNameCodeSequence,
    kPlateID,
    kScheduledProcedureStepLocation,
    kScheduledStationAETitle,
    kScheduledStationGeographicLocationCodeSequence,
    kScheduledStationName,
    kScheduledStationNameCodeSequence,
    kScheduledStudyLocation,
    kScheduledStudyLocationAETitle,
    kStationName];



}
  