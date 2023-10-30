@protocol: 'rest'

@open
service AWSService {
     type object {};

      function FileList() returns array of object;
      function File(FileName: String) returns object;
      action UploadFile() returns object;
}