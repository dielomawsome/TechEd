using {sap.ui.riskmanagement as my} from '../db/schema';

@path: 'service/incident'
service IncidentsService {

  @odata.draft.enabled
  entity Incidents   as projection on my.Incidents;

  entity Mitigations as projection on my.Mitigations;

  //This is a custom type, which is necessary to return a list of files since we have no 
  //Database entities we can refer to for this purpose
  type Item {
    Name          : String;
    LastModified  : String;
    ETag          : String;
    Size          : String;
    Owner         : {
      ID          : String;
      DisplayName : String;
    };
    StorageClass  : String;
    FileLocation  : String;
  }
  
  // returns a list of files uing the AWS S3 bucket objects
  function FileList()              returns array of Item; 
}
