using {sap.ui.riskmanagement as my} from '../db/schema';

@path: 'service/incident'
service IncidentsService {

  @odata.draft.enabled
  entity Incidents   as projection on my.Incidents;

  entity Mitigations as projection on my.Mitigations;

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

  type object {}; // Allows us to work with unstructered data
  function FileList()              returns array of Item; // returns a list of files uing the AWS S3 bucket objects
  function File(FileName : String) returns object; // returns a single file in Base64
}
