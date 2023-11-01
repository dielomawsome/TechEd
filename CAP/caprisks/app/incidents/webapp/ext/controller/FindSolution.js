/* eslint-disable no-undef */
sap.ui.define(["sap/m/Button", "sap/m/Dialog", "sap/m/FormattedText"], function (Button, Dialog, FormattedText) {
  "use strict";

  return {
    onPress: async function (oEvent) {
      try {
        this._view.setBusy(true);

        //creating the data and headers for all call
        const title = oEvent.getProperty("title"); //could be 'descr' too if you prefer

        const headers = new Headers();
        headers.append("Content-Type", "application/json");

        const body = JSON.stringify({
          Question: title,
        });

        //this calls the AWS API Gateway endpoint
        const response = await fetch("https://w2n1b8qko7.execute-api.us-east-1.amazonaws.com/v2/fix", {
          method: "POST",
          headers,
          body,
          redirect: "follow",
        });

        // this nugget of regex is to remove the quotes from the response and to convert the \n to <br/>
        const htmlText = (await response.text()).replace(/\\n/g, "<br/>").replace(/^"[\s]*|\s*"$/gi, "");

        //construct and open a dialog
        const dialog = new Dialog({
          title: "Solution",
          contentWidth: "760px",
          content: new FormattedText({ htmlText }),
          beginButton: new Button({
            text: "Close",
            press: function () {
              dialog.close();
            },
          }),
          afterClose: function () {
            dialog.destroy();
          },
        });

        //to make the dialog responsive
        dialog.addStyleClass("sapUiResponsivePadding--content sapUiResponsivePadding--header sapUiResponsivePadding--footer sapUiResponsivePadding--subHeader");
        this._view.setBusy(false);
        dialog.open();
      } catch (e) {
        console.log(e);
      }
    },
  };
});
