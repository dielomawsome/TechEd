TechEd Watch-and-code CodeJam

# SAP BTP Trial Account Setup - Murali - Diego to pre-populate from OpenSAP & Murali to validate.
## Steps to create BTP Trial Account

# SAP BTP Development Environment Setup - Jorg & Murali
## Option 1: SAP Business Application Studio
Steps to setup Business Appliation Studio 
Check if OpenSAP steps can be used.
## Option 2: Local Visual Studio Code option
### Mac Version

### Windows Version

# SAP CodeJam Exercise
Based on: https://github.com/SAP-samples/cap-service-integration-codejam/tree/main/exercises/12-extend-fiori-ui-with-annotations![image](https://github.com/dielomawsome/TechEd/assets/124110484/ebf68800-9586-4401-836f-6f5d09ea929f)

## Pre-built content / git repository - Jorg

## Steps to follow - Jorg

# AWS Account Setup - Derek
## Provision AWS Account using Workshop Studio 

# AWS CodeJam 

In this section of the CodeJam you're going to extend the application that you built this morning. 
There are two separated parts for this session.
First, you're going to add the ability to add an attachment to the records you create in the BTP Application. These attachments will be stored in Amazon Simple Storage Services (a.k.a. S3), which is a realiable and cost effective object store service. 
In order to do this, you will create an S3 Bucket (Buckets are object containers), then you will create a Role to provide access to the S3 Bucket and finally an API which will allow you to interact with the S3 bucket from the BTP Application. 

## Part 1 - Attach a document
### Create S3 Bucket - 

1. Access S3 Console

Enter S3 in the search bar and select S3 from the dropdown menu.
![Alt text](images/image.png)

2. Create bucket

On the main S3 console, click on the Crate bucket button on the right
![Alt text](images/image-1.png)

3. Enter bucket name

Enter a bucket name. The bucket name needs to be unique across all AWS accounts. 
A good idea would be to call it <your_name-teched-codejam>.

![Alt text](images/image-2.png)

4. Scroll down and click on Create bucket

![Alt text](image-3.png)

5. Access the S3 bucket to retrieve the bucket resource name

This will be required on a subsequent step, when we need to provide authorise our API to access to the S3 Bucket
Click on the bucket name on the list
![Alt text](image-4.png)

6. Select Properties

![Alt text](image-5.png)

7. Copy the Amazone Resource Name (ARN)

Clicking on the button to the left of the name will copy the ARN.
![Alt text](image-6.png)

That's the S3 bucket created. 

### Setup IAM Role - Diego

### Create API in API Gateway - Diego
1. Put
2. Get

### SAP BTP App Modifications - Shaun
1. Add button to add attachment
Is a popup screen needed?
Add a field on the DB to store attachment details so it can be retrieved. 
3. Call API Put
4. Add button to retrieve attachment
5. Call API Get

## Step 2 - Find a solution using Amazon Bedrock
### API Details - Diego
Check Google API call's limit
Do we need Google?
### Add button in SAP BTP App to call API - Shaun
### Display results in SAP BTP App - Shaun

## Optional Step 3 - Add a notification when a file is attached - Diego
This might be too much. 
