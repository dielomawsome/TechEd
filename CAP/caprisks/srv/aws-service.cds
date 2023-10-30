@protocol: 'rest'
@open
service AWSService {
    type object {}; // Allows us to work with unstructered data
    function FileList()              returns array of object; // returns a list of files uing the AWS S3 bucket objects
    function File(FileName : String) returns object; // returns a single file in Base64
}