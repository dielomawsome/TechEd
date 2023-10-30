// @protocol: 'rest'
// @open
//   {
//     "Key": "ad-1.pdf",
//     "LastModified": "2023-10-27T22:51:30.000Z",
//     "ETag": "\"af16133caa8c33e9a94dd786d44a81b8\"",
//     "Size": "32920",
//     "Owner": {
//       "ID": "3578910fb9472b26a41c56f007569108327915d32303bd1516bb4db8b4770629",
//       "DisplayName": "dielom"
//     },
//     "StorageClass": "STANDARD",
//     "FileLocation": "https://2jm9jcmsc5.execute-api.us-east-1.amazonaws.com/v1/appgyver-1/ad-1.pdf"
//   },

service AWSService {
    type Item {
        Name: String;
        LastModified: String;
        ETag: String;
        Size: String;
        Owner: {
            ID: String;
            DisplayName: String;
        };
        StorageClass: String;
        FileLocation: String;
    }
    type object {}; // Allows us to work with unstructered data
    function FileList()              returns array of Item; // returns a list of files uing the AWS S3 bucket objects
    function File(FileName : String) returns object; // returns a single file in Base64
}