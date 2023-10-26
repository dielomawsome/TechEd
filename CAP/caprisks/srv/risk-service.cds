using { sap.ui.riskmanagement as my } from '../db/schema';
@path: 'service/incident'
service IncidentsService {
 
  @odata.draft.enabled
  entity Incidents as projection on my.Incidents;
  entity Mitigations as projection on my.Mitigations;
  // entity Employees as projection on my.Employees;
}