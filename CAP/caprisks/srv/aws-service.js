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
    


srv.on('File', async (req) => {
    if (!req.data.FileName) {
        console.log(req.data)
        throw new Error('Missing FileName in request data');
    }

    try {
        const url = `https://2jm9jcmsc5.execute-api.us-east-1.amazonaws.com/v1/appgyver-1/${req.data.FileName}`;

        var myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/pdf");

        var requestOptions = {
            method: 'GET',
            headers: myHeaders,
            redirect: 'follow'
        };

        const response = await fetch(url, requestOptions);

        if (!response.ok) {
            throw new Error(`HTTP Error: ${response.status} - ${response.statusText}`);
        }

        // Extract filename and content type
        const pdfFilename = `${req.data.FileName}.pdf`;
        const contentType = 'application/pdf';

        // Read the PDF content as an ArrayBuffer
        const pdfBuffer = await response.arrayBuffer();

        if (pdfBuffer) {
            // Convert the ArrayBuffer to a base64 string
            const base64Data = Buffer.from(pdfBuffer).toString('base64');

            // Return the response with filename, mimetype, and base64 data
            return {
                filename: pdfFilename,
                mimetype: contentType,
                data: base64Data
            };
        } else {
            throw new Error('Empty PDF file content');
        }
    } catch (error) {
        console.error('Error:', error);
        throw error; // Re-throw the error for better error handling
    }
});

    
});