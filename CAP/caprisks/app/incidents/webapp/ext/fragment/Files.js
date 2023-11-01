/* eslint-disable no-undef */
sap.ui.define(["sap/m/MessageToast"], function (MessageToast) {
  "use strict";
  let file;

  const url = 'https://2jm9jcmsc5.execute-api.us-east-1.amazonaws.com/v2/appgyver-1'
  return {
    handleUploadPress: async function () {
      if (file) {
        try {

          //creating the data and headers for all call
          const headers = new Headers();
          headers.append("Content-Type", file.type);
          
          const body = new FormData();
          body.append("file", file, file.name);
          body.append("name", file.name);
          
          //this calls the AWS API Gateway endpoint
          await fetch(`${url}/${file.name}`, {
            method: 'PUT',
            headers,
            body
          });

          //refresh the list so our new file shows up in the list
          this.byId('fe::CustomSubSection::Files--list').getBinding('items').refresh()
          MessageToast.show("File uploaded successfully")
        } catch(e) {
          MessageToast.show("Error! File not uploaded");
        }

        file = null;
      }
    },
    handleChange: function (oEvent) {
      //storing the file in a variable so we can use it later
      file = oEvent.getParameter("files")[0];
    },

    onListItemPress: function (oEvent) {
      const { FileLocation } = oEvent.getSource().getBindingContext().getObject();
      window.open(FileLocation, "_blank");
    }
  };
});
