TechEd Watch-and-code CodeJam

# Prerequisites
In order to participate in this CodeJam, you will need a BTP account.
If you have an account already, you can use that.
Alternatively you can setup a Trial account following these steps: https://developers.sap.com/tutorials/hcp-create-trial-account.html

# Development Environment Setup

We have two options for you to work on this CAP development. The first is setting up a a BTP Account and activating Business Application Studio, which comes with all the necessary tools you need out of the box. 

The other option is setting up the same tools on your own machine. Both approaches are equally valid.

## Option 1: SAP Business Application Studio

### Create a BTP Trial Account

For those who do not have a trial account or who do not have access to BTP yet, SAP produced a handy guide on how to set up a trial account, available [here](https://developers.sap.com/tutorials/hcp-create-trial-account.html). 

### Set up and start Business Application Studio

These days trial accounts come with BAS pre-activated. If you can't find it To set up BAS on a BTP environment, the necessary steps can be found in [this handy guide](https://developers.sap.com/tutorials/set-up-bas.html)

## Option 2: Local Visual Studio Code option

Follow these instructions as required. To work with CAP locally, a few tools need to be installed. The SAP documentation has a good [Jumpstart devvelopment](https://cap.cloud.sap/docs/get-started/jumpstart) section. There's also is a handy [setup guide](/CAP/Setup.md) we wrote that is a bit more comprehensive on how to work with a terminal on windows or Mac. 

# SAP CodeJam Exercise
Based on: [The SAP CodeJam](https://github.com/SAP-samples/cap-service-integration-codejam/tree/main/exercises/12-extend-fiori-ui-with-annotations)

## Pre-built content / git repository - Jorg

## Steps to follow - Jorg
Follow Tutorial 1 to [Create a CAP-Based Application](/CAP/1.%20CreateApplication.md). The summary is below:

<details>

1. Create an empty NodeJS application with `npm init`
2. Initialise an empty CAP application with `cds init && npm install`
3. Start your app in development mode with `cds watch`
3. Add a schema file
4. Add an entity for Incidents
5. Add some mock data for your entity 
6. Create a service cds file
7. Create an IncidentsService and add a projection to your entity
7. View your service and the metadata on your localhost
8. Create your first annotation and enable draft functionality on your Incidents projection
9. Add a *Composition* for comments and provide some sample data
10. Add an *Association* for Incident type and provide some sample data

</details>

Follow Tutorial 2 to [Create a Fiori Elements Application](/CAP/2.%20CreateFioriElementsUI.md)
<details>

1. Create a Fiori Elements application with the wizard of type List Report / Object Page
2. Use the *Page map* to add some columns to the list report, and some fields to the object page
3. Use the *Page map* to turn the Incident type field into a search help

</details>

# AWS Account Setup


### Add button in SAP BTP App to call API - Shaun


### Display results in SAP BTP App - Shaun

