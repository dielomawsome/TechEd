
/**
 * Implementation for Risk Management service defined in ./risk-service.cds
 */
var parser = require("xml2json");

module.exports = async (srv) => {
    srv.after('READ', 'Incidents', risksData => {
        const risks = Array.isArray(risksData) ? risksData : [risksData];
        risks.forEach(risk => {
            if (risk.impact >= 100000) {
                risk.criticality = 1;
            } else {
                risk.criticality = 2;
            }
        });
    });

    srv.on("FileList", async () => {
        try {
          const response = await fetch(
            "https://2jm9jcmsc5.execute-api.us-east-1.amazonaws.com/v1/appgyver-1/"
          );
          if (!response.ok) {
            throw new Error(
              `HTTP Error: ${response.status} - ${response.statusText}`
            );
          }
    
          const result = await response.text();
          const data = parser.toJson(result);
          const filesJson = JSON.parse(data);
    
          if (
            filesJson &&
            filesJson.ListBucketResult &&
            filesJson.ListBucketResult.Contents
          ) {
            const files = filesJson.ListBucketResult.Contents.map((file) => {
              file.FileLocation = "https://2jm9jcmsc5.execute-api.us-east-1.amazonaws.com/v1/appgyver-1/" + file.Key;
              return file;
            }).filter((file) => {
              if (file.Key.endsWith(".pdf")) {
                return file;
              }
            });
            return files.map(f => ({Name: f.Key, ...f}));
          } else {
            throw new Error("Invalid response data structure");
          }
        } catch (error) {
          console.error("Error:", error);
          throw error; // Re-throw the error for better error handling up the chain
        }
      });

};