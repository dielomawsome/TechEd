namespace sap.ui.riskmanagement;

using {
  managed,
  cuid,
  sap.common.CodeList
} from '@sap/cds/common';

entity Incidents : cuid, managed {
  title       : String(100);
  prio        : String(5);
  descr       : String;
  mitigations : Composition of many Mitigations
                  on mitigations.incident = $self;
  impact      : Integer;
  criticality : Integer;
  type: Association to Type;
}

entity Mitigations : cuid, managed {
  description : String;
  timeline    : String;
  incident    : Association to one Incidents;
}

entity Type : CodeList {
  key code: Integer;
}