# TechEd Watch-and-code Meetup

Welcome to the TechEd Watch-and-code! In this repository you'll find the application and the steps we'll be following for the Demo Jam!

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

Follow these instructions as required. To work with CAP locally, a few tools need to be installed. The SAP documentation has a good [Jumpstart devvelopment](https://cap.cloud.sap/docs/get-started/jumpstart) section. There's also is a handy [setup guide](/CAP/0.%20Setup.md) we wrote that is a bit more comprehensive on how to work with a terminal on windows or Mac. 

## About this repository

Inside this repository you'll find a folder called `CAP`. In here is the sample app and the steps for the exercise. 

[`CAP/caprisks`](./CAP/caprisks/) is the CAP application you'll be replicating. 

The exersices themselves can be found in:
1. [Creating a CAP application](./CAP/1.%20CreateApplication.md)
2. [Creating a Fiori Elements Application](./CAP/2.%20CreateFioriElementsUI.md)

Followed by 

3. [Setting up some services in AWS](./CAP/3.%20SetupAWS.md)
4. [Extending our Fiori application to include the AWS API's](./CAP/4.%20ExtendWithAWS.md)

If you decide to run our application, open up your terminal, navigate to `/CAP/caprisks/` and execute:
```sh
npm install 
cds watch
```