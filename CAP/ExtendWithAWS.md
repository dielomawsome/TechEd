# Extend your Fiori Elements Application to use AWS service

Now, we're going to extend our CAP application from the earlier session to use two AWS services:
1. We'll add a custom fragment to our object page to display and upload a PDF to an S3 bucket
2. We'll add a custom bucket to the object page header to find a solution to our problem via the generative AI service called Bedrock

To extend Fiori Elements, we will use the Page Map in all examples going forward

## 1. Add PDF's to our Incident

### Add a custom section to the UI using the Page Map

To add an extension to the body of a Fiori Elements app, choose the edit function on the Object Page and choose to add a new section

<img src="../images/CustomSection.png">

From there, choose to add a new section with a new Fragment and a new implementation, following the Mitigations section. You can give it any name you like, we're calling ours `Files`, which results in

<img src="../images/CustomFiles.png">

There are two things to implement here. You'll see a fragment and a handler. 

```xml
<core:FragmentDefinition xmlns:w="sap.ui.webc.main" xmlns:core="sap.ui.core" xmlns="sap.m"
	xmlns:macros="sap.fe.macros">
	<VBox>
		<HBox>
			<w:FileUploader placeholder="Upload file..." core:require="{ handler: 'ns/incidents/ext/fragment/Files'}" change="handler.handleChange"></w:FileUploader>
			<Button
				text="Upload File"
				core:require="{ handler: 'ns/incidents/ext/fragment/Files'}"
				press="handler.handleUploadPress" />
		</HBox>
		<List
			id="list"
			enableBusyIndicator="true"
			headerText="List from AWS"
			growing="true"
			items="{
				path: '/FileList()'
			}">
			<ObjectListItem
				title="{Name}"
				type="Active"
				core:require="{ handler: 'ns/incidents/ext/fragment/Files'}"
				press="handler.onListItemPress"
				number="{= Math.round(${Size} / 1024) } KB" />
		</List>
	</VBox>
</core:FragmentDefinition>
```

And we have our handler:

```js
/* eslint-disable no-undef */
sap.ui.define(["sap/m/MessageToast"], function (MessageToast) {
  "use strict";
  let file;

  const url = 'https://2jm9jcmsc5.execute-api.us-east-1.amazonaws.com/v2/appgyver-1'
  return {
    handleUploadPress: async function () {
      if (file) {
        try {
          const headers = new Headers();
          headers.append("Content-Type", file.type);
          
          const body = new FormData();
          body.append("file", file, file.name);
          body.append("name", file.name);
          
          await fetch(`${url}/${file.name}`, {
            method: 'PUT',
            headers,
            body
          });

          this.byId('fe::CustomSubSection::Files--list').getBinding('items').refresh()
          MessageToast.show("File uploaded successfully")
        } catch(e) {
          MessageToast.show("Error! File not uploaded");
        }

        file = null;
      }
    },
    handleChange: function (oEvent) {
      file = oEvent.getParameter("files")[0];
    },

    onListItemPress: function (oEvent) {
      const { FileLocation } = oEvent.getSource().getBindingContext().getObject();
      window.open(FileLocation, "_blank");
    }
  };
});
```

## 2. Use generative AI to find a solution

Bedrock is an AWS service that allows the developer to easily add a generative AI solution to a problem. In this case we'll use it to try and add a solution to an incident. 

### Add a custom button to the Object Page

<img src="../images/CustomAction.png">

When prompted, call it `FindSolution`. A new file will pop up in the `ext/controller` path of your app and it will implement the `onPress` method that you find on regular old buttons. This is the default:

```js
sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        onPress: function(oEvent) {
            MessageToast.show("Custom handler invoked.");
        }
    };
});
```

If you now go to an incident in your application you'll find a button at the top, near the Edit option, called Find Solution. 

<img src="../images/CustomButton.png">


If you press your shiny new button, you will indeed see the Message Toast pop up saying that the custom handler is invoked. However we don't want a message toast, we want a Dialog outlining a possible solution to our problem, so we're going to replace the `onPress` method to call the Bedrock via AWS API Gateway

```js
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
```

### Call Bedrock from the custom button
