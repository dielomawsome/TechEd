namespace sap.ui.riskmanagement;

using {managed} from '@sap/cds/common';

entity Incidents : managed {
  key ID          : UUID @(Core.Computed: true);
      title       : String(100);
      prio        : String(5);
      descr       : String;
      mitigations : Composition of many Mitigations
                      on mitigations.IncidentID = ID;
      impact      : Integer;
}

entity Mitigations : managed {
  key ID            : UUID @(Core.Computed: true);
      IncidentID    : UUID;
      description   : String;
      ownerEmployee : Association to Employees;
      timeline      : String;
      incidents     : Association to one Incidents
                        on incidents.ID = IncidentID;
}

entity Employees {
  key ID            : String                                @title: 'ID'            @Common: {
        SemanticObject : 'employee',
        Text           : name,
        TextArrangement: #TextOnly
      };
      name          : String                                @title: 'Name';
      email         : String                                @title: 'e-mail'        @Communication.IsEmailAddress;
      phone         : String                                @title: 'Phone Number'  @Communication.IsPhoneNumber;
      mitigations : Association to many Mitigations on mitigations.ownerEmployee = $self @title: 'Mitigations';
};
