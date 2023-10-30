var parser = require('xml2json');



module.exports = cds.service.impl(async (srv) => {
    srv.on('FileList', async (request) => {
    
        try {
            const response = await fetch("https://2jm9jcmsc5.execute-api.us-east-1.amazonaws.com/v1/appgyver-1/");
            if (!response.ok) {
                throw new Error(`HTTP Error: ${response.status} - ${response.statusText}`);
            }
            
            const result = await response.text();
            const data = parser.toJson(result);
            const filesJson = JSON.parse(data);
            
            if (filesJson && filesJson.ListBucketResult && filesJson.ListBucketResult.Contents) {
            
                const files = filesJson.ListBucketResult.Contents.map(file=>{
                    file.FileLocation = "https://2jm9jcmsc5.execute-api.us-east-1.amazonaws.com/v1/appgyver-1/" + file.Key
                    return file
                }).filter(file=>{
                    if(file.Key.endsWith(".pdf")){
                        return file
                    }
                })
                return files;
            } else {
                throw new Error('Invalid response data structure');
            }
        } catch (error) {
            console.error('Error:', error);
            throw error; // Re-throw the error for better error handling up the chain
        }
    });
    
    
});