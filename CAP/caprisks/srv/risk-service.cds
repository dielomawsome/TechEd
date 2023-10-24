using { sap.ui.riskmanagement as my } from '../db/schema';
@path: 'service/incident'
service IncidentsService {
  entity Incidents as projection on my.Incidents;
  entity Mitigations as projection on my.Mitigations;
    annotate Mitigations with @odata.draft.enabled;
  entity Employees as projection on my.Employees;
}