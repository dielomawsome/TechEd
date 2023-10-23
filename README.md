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

For those who do not have a trial account or who do not have access to BTP yet, SAP produced a handy guide on how to set up a trial account, available [here](https://developers.sap.com/tutorials/hcp-create-trial-account.html)

### Set up and start Business Application Studio

To set up BAS on a BTP environment, the necessary steps can be found in [this handy guide](https://developers.sap.com/tutorials/set-up-bas.html)

## Option 2: Local Visual Studio Code option

Follow these instructions as required. To work with CAP locally, a few tools need to be installed. There is a handy [setup guide](/CAP/Setup.md) we wrote. 

# SAP CodeJam Exercise
Based on: [The SAP CodeJam](https://github.com/SAP-samples/cap-service-integration-codejam/tree/main/exercises/12-extend-fiori-ui-with-annotations)

## Pre-built content / git repository - Jorg

## Steps to follow - Jorg
Follow Tutorial 1 to [Create a CAP-Based Application](/CAP/CreateApplication.md)
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

Follow Lesson 2 to Create a Fiori Elements Application
11. Create a Fiori Elements application with the wizard of type List Report / Object Page
12. Use the *Page map* to add some columns to the list report, and some fields to the object page
13. Use the *Page map* to turn the Incident type field into a search help

# AWS Account Setup
## Provision AWS Account using Workshop Studio 

<details>

1. Access this URL or scan the QR code below: 

    **https://catalog.us-east-1.prod.workshops.aws/join?access-code=377a-0cdfa0-95** 

    ![Alt text](./images/image-60.png)

2. Select Email one-time password (OTP)

    ![Alt text](./images/image-61.png)

3. Provide an Email address that you have access to, then click on **Send passcode**.

    You can use your corporate or personal email address. 

    ![Alt text](./images/image-62.png)


4. Check your email for the passcode. 


    ![Alt text](./images/image-63.png)


5. Copy this 9-digit into the Passcode field, then click on **Sign in**. 

    ![Alt text](./images/image-64.png)

    ![Alt text](./images/image-65.png)

6. You will be prompted to Review and join the event. 

    ![Alt text](./images/image-66.png)

7. Scroll down to review all the Terms and conditions, then check the box for **I agree with the Terms and Conditions**, and click on **Join event**.

    ![Alt text](./images/image-67.png)


8. Now you'll be in your Event dashboard, which will look similar to the screenshot below. 

    For this CodeJam, you can ignore the top section of the menu on the left and the main content of the workshop. You have to click on the **Open AWS Console** link, as highlighted in RED below. 
    
    ![Alt text](./images/image-68.png) 

9. Once the link opens, you will be inside the AWS Console, where all services are available.

    You're now ready to go!

    ![Alt text](./images/image-69.png)

</details>

# AWS CodeJam 

In this section of the CodeJam you're going to extend the application that you built this morning. 
There are two separated parts for this session.
First, you're going to add the ability to add an attachment to the records you create in the BTP Application. These attachments will be stored in Amazon Simple Storage Services (a.k.a. S3), which is a realiable and cost effective object store service. 
In order to do this, you will create an S3 Bucket (Buckets are object containers), then you will create a Role to provide access to the S3 Bucket and finally an API which will allow you to interact with the S3 bucket from the BTP Application. 

## Part 1 - Attach a document
### Step 1 - Create S3 Bucket

The first step is to create an S3 bucket. There are a number of options available for S3 buckets, including cross region replication, versioning as well as events and notifications. For now you're going to go with a basic setup. 

<details>
1. Access S3 Console

Enter S3 in the search bar and select S3 from the dropdown menu.
![Alt text](./images/images/image.png)

2. Create bucket

On the main S3 console, click on the Crate bucket button on the right
![Alt text](./images/images/image-1.png)

3. Enter bucket name

Enter a bucket name. The bucket name needs to be unique across all AWS accounts. 
A good idea would be to call it <your_name-teched-codejam>.

![Alt text](./images/images/image-2.png)

4. Scroll down and click on Create bucket

![Alt text](./images/image-3.png)

5. Access the S3 bucket to retrieve the bucket resource name

This will be required on a subsequent step, when we need to provide authorise our API to access to the S3 Bucket
Click on the bucket name on the list
![Alt text](./images/image-4.png)

6. Select Properties

![Alt text](./images/image-5.png)

7. Copy the Amazone Resource Name (ARN)

Clicking on the button to the left of the name will copy the ARN.
![Alt text](./images/image-6.png)

That's the S3 bucket created. 
</details>

### Step 2 - Setup IAM Role

Next you will need to create a policy to provide access to your S3 bucket and assign this to a Role that you will also create. You will use this role later on when creating the API. 


<details>
1. Access IAM console

On the search bar, type IAM (Identity Access Management), and select IAM from the menu.

![Alt text](./images/image-7.png)

2. Create Policy

Select policies from the left side panel

 ![Alt text](./images/image-8.png)
 
Click on the Create policy button
 ![Alt text](./images/image-9.png)


Switch the policy editor to JSON clicking on the button 
![Alt text](./images/image-10.png)

Copy and paste the following policy in the Policy Editor.
Replace the resource with the ARN you copied before, or just replace the <your_bucket> text with the name of your bucket (without <>). Ensure that the /* are included at the end of the ARN.
This policy enables access to read and write objects from your S3 bucket as well as listing objects within the bucket. 

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"		
            ],
            "Resource": "arn:aws:s3:::<your_bucket>/*"
        }
}
```

![Alt text](./images/image-11.png)

Click next and enter a policy name

![Alt text](./images/image-12.png)

Scroll down and click Create policy

![Alt text](./images/image-13.png)

You can now search and see your policy.

![Alt text](./images/image-14.png)

3. Create Role

Select the Roles menu entry from the side panel

![Alt text](./images/image-15.png)

Click Create role

![Alt text](./images/image-16.png)

On the next screen, select Custom trust policy. This will enable the role we're creating to be used by our API. The action sts:AssumeRole allows a service or instance to adopt a role while it is performing an action. The service "apigateway.amazonaws.com" specifies that we're allowing the API Gateway service to use this role. 
Copy the following code and paste it on the Custom trust policy section
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
            "Service": "apigateway.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
} 
```

![Alt text](./images/image-17.png)

Scroll down and click Next

![Alt text](./images/image-18.png)

On the next screen, you will add the policy you just created to this role. Search for the policy and select it using the checkbox next to the name. Click Next. 

![Alt text](./images/image-19.png)

Enter a name for your role

![Alt text](./images/image-20.png)

Scroll down and click Create role

![Alt text](./images/image-21.png)

4. Get Amazon Resource Name (ARN) for the role.

This will be required for to create the API. Search for your role and click on the name.

![Alt text](./images/image-22.png)

Copy the ARN. You can click on the button on the left to do so. 

![Alt text](./images/image-23.png)
</details>

### Step 3 - Create API in API Gateway

The next step is to create an API to access the S3 bucket. 
We will enable the option to save and read files from S3.
This is done by implementing the PUT and GET methods.

<details>


1. Access API Gateway

Search for API Gateway and click on the service on the menu

![Alt text](./images/image-24.png)

The API Gateway UI is going through a redesign. You're going to use the new console so click on the option at the top within the blue bar or the option on the left panel

![Alt text](./images/image-25.png)

2.  Create REST API

On the API Gateway screen, scroll down to REST API
![Alt text](./images/image-26.png)

Click Build

![Alt text](./images/image-27.png)

Select New API. Enter a name for your API. The endpoint type should be set to Regional. 
Click on Create API
![Alt text](./images/image-28.png)


3. Create Resources

The resources will allow us to map the URL call to the S3 Bucket and the file. 
Click on create resource

![Alt text](./images/image-29.png)

The first resource will be called {folder}. This will be used in the API URL to indicate the bucket name. 
Tick the CORS checkbox and click Create resource

![Alt text](./images/image-30.png)

Create another resource (ensure you have {folder} selected which would be by default after creating it)

![Alt text](./images/image-31.png)

This resource you're going to name it {item} and will represent the file name in the API call.
Ensure that /{folder}/ is the preceding resource. 
Tick the CORS checkbox and click Create resource

![Alt text](./images/image-32.png)


4. Create GET Method

Now you're going to create the GET method to read the files.
Click on Create method. Emsure you've selected {item} on the resources path on the left. This would be the default after creating the resource

![Alt text](./images/image-33.png)


On the next screen, first select GET as the method. This defines the GET method for the API we're creating.
Then click on the AWS Service box. 
Select the region us-east-1 and Simple Storage Service (S3) from the AWS Service from the respective dropdowns. 

![Alt text](./images/image-34.png)
 
Scroll down and select the GET method. This select the GET Method from the S3 service. 
Select the Use path override radio button as Action type.
In the Path override field enter {bucket}/{object}. This will define the path to call the S3 API and will allow you to map the resources defined previously.
In the execution role, enter the ARN for the role you created earlier. This allows the API to utilise the policies defined in the role when it is invoked. 
Click on Create method

![Alt text](./images/image-35.png)

The next step is to map the url parameters to the Bucket and Object parameters from our S3 bucket.
With the GET method selected on the tree on the left, click on Integration request (any of the two highlighted options)

 ![Alt text](./images/image-36.png)

Click Edit

![Alt text](./images/image-37.png)

Scroll down

![Alt text](./images/image-38.png)

Expand the URL path parameters and click add path parameter 

![Alt text](./images/image-39.png)

Add the two parameters as per the mapping below. This maps the folder and item (file) from the URL to the S3 bucket and object names.

    ```
    Name: bucket - Mapped from: method.request.path.folder 
    Name: object – Mapped from: method.request.path.item
    ```

Click Save

![Alt text](./images/image-40.png)


5. Create PUT Method

Next you will create the PUT method. The steps are the same as with the GET method, with the exception of selecting PUT instead of GET.
First click on {item} so you're on the right place and the Create method button will display on the right panel.

![Alt text](./images/image-41.png)

Click in Create method

![Alt text](./images/image-42.png)

Select the PUT method.
As before, select AWS Service, us-east-1 and Simple Storage Service (S3)

![Alt text](./images/image-43.png)

Scroll down and select the PUT method. 
Select Use path override, enter {bucket}/{object} and the ARN from your role.
Click Create method once you're done.

![Alt text](./images/image-44.png)

Next select Integration request from any of the two options.

![Alt text](./images/image-45.png)

Click Edit

![Alt text](./images/image-46.png)


Scroll down

![Alt text](./images/image-47.png)

Expand URL path paremeters and add the two parameters, same as with the GET Method. 


![Alt text](./images/image-48.png)

 ```
    Name: bucket - Mapped from: method.request.path.folder 
    Name: object – Mapped from: method.request.path.item
```

Click Save

![Alt text](./images/image-49.png)

6. Enable Binary media types

By default, binary media types are not permitted. 
In this case, you're going to enable PDF files. 
Click on API Settings on the left panel

![Alt text](./images/image-50.png)

Click on Manage media types

![Alt text](./images/image-51.png)

Click on Add binary media type

![Alt text](./images/image-52.png)

Enter application/pdf and click Save changes

![Alt text](./images/image-53.png)


7. Deploy API

Click on Resources on the left side panel

![Alt text](./images/image-54.png)

Click on the Deploy API button

![Alt text](./images/image-55.png)

Next you have to select a Stage. A stage allows you to have different versions of an API. This is commonly used to differentiate versions.

![Alt text](./images/image-56.png)

Since it is the first time you're deploying, you have to create a stage. Select New Stage from the dropdown

![Alt text](./images/image-57.png)

Enter a name (i.e.: v1). This will be used in the API URL.
Click on Deploy.

![Alt text](./images/image-58.png)

The API is now ready to be used. You can see the URL in the Invoke URL field

![Alt text](./images/image-59.png)

</details>

### SAP BTP App Modifications - Shaun
1. Add button to add attachment
Is a popup screen needed?
Add a field on the DB to store attachment details so it can be retrieved. 
3. Call API Put
4. Add button to retrieve attachment
5. Call API Get

## Part 2 - Find a solution using Amazon Bedrock

In the second step you're going to call a pre-defined API to find a solution for the incidents you create in your BTP application.
The API provided below will receive a question (in the body of the call) and will first perform an internet search for a solution and provide a step by step set of instructions for you to solve your problem. This API leverages the Generative AI capability provided by Amazon Bedrock and the Anthropic Claude Foundation Model. 

### API Details:

https://w2n1b8qko7.execute-api.us-east-1.amazonaws.com/v1/fix

### Body:

```
{
	"Question" : "<TITLE OF THE INCIDENT FROM BTP>"
}
```


### Add button in SAP BTP App to call API - Shaun


### Display results in SAP BTP App - Shaun

