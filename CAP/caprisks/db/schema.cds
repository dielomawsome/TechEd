namespace sap.ui.riskmanagement;

using {
  managed,
  cuid
} from '@sap/cds/common';

entity Incidents : cuid, managed {
  title       : String(100);
  prio        : String(5);
  descr       : String;
  mitigations : Composition of many Mitigations
                  on mitigations.incident = $self;
  impact      : Integer;
  criticality : Integer;
  employee    : Association to Employees;
}

entity Mitigations : cuid, managed {
  description : String;
  timeline    : String;
  incident    : Association to one Incidents;
}

entity Employees {
  key ID        : String  @title: 'ID'            @Common: {
        SemanticObject : 'employee',
        Text           : name,
        TextArrangement: #TextOnly
      };
      name      : String  @title: 'Name';
      email     : String  @title: 'e-mail'        @Communication.IsEmailAddress;
      phone     : String  @title: 'Phone Number'  @Communication.IsPhoneNumber;
      incidents : Association to many Incidents
                    on incidents.employee = $self;
};
