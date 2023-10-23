# Create a CAP-Based Application :computer:
This tutorial shows you how to create a new CAP-based application, which exposes the OData V4 protocol.
You will learn
- How to use the CAP’s tooling cds init to create your project
- How to use the CAP’s tooling cds watch to launch your project
- How to add files to your project

The full code base of the CAP app can be found [here](./caprisks/) should you need to check or copy the code


### Step 1 - Create and initialize the project
1. Open a command line window.

2. Create a new directory for your application 
```bash
mkdir caprisks
```

3. Switch to your project root folder.
```bash
cd caprisks
```

4. Create an initial CAP project by executing the command ```cds init```.
```bash
cds init
```

<img src="../images/CDSInit.png" width="500">


5. Open the project in VS Code.
```bash
code .
```

<img src="../images/InitialProject.png" width="300">

6. In VS Code choose Terminal → New Terminal from its menu.
A new terminal opens in the lower right part of the VS Code screen.

7. In the VS Code terminal, run the following command.
This installs all the dependencies for the project.  You can find these listed in the ```package.json``` file
```bash
npm install
```
<img src="../images/npmInstall.png" width="500">

8. In the VS Code terminal, start a CAP server.
```bash
cds watch
```
The CAP server serves all the CAP sources from your project. It also “watches” all the files in your projects and conveniently restarts whenever you save a file. Changes you have made will immediately be served without you having to do anything

The screen now looks like this:

<img src="../images/CDSWatchEmpty.png" width="500">

The CAP server tells you that there is no model and no service definitions yet that it can serve. You add some in the next step.

### Step 2 - Add files to the project

1. Create the database tables
Create a new file in the ``db`` folder called ``schema.cds``

Copy the code here and paste it into the file.   

```js
namespace sap.ui.riskmanagement;

using {managed} from '@sap/cds/common';

entity Incidents : managed {
  key ID          : UUID @(Core.Computed: true);
      title       : String(100);
      prio        : String(5);
      descr       : String;
      mitigations : Composition of many Mitigations
                      on mitigations.IncidentID = ID;
      impact      : Integer;
}

entity Mitigations : managed {
  key ID            : UUID @(Core.Computed: true);
      IncidentID    : UUID;
      description   : String;
      ownerEmployee : Association to Employees;
      timeline      : String;
      incidents     : Association to one Incidents
                        on incidents.ID = IncidentID;
}

entity Employees {
  key ID            : String                                @title: 'ID'            @Common: {
        SemanticObject : 'employee',
        Text           : name,
        TextArrangement: #TextOnly
      };
      name          : String                                @title: 'Name';
      email         : String                                @title: 'e-mail'        @Communication.IsEmailAddress;
      phone         : String                                @title: 'Phone Number'  @Communication.IsPhoneNumber;
      mitigations : Association to many Mitigations on mitigations.ownerEmployee = $self @title: 'Mitigations';
};
```
It creates three entities in the namespace ``sap.ui.riskmanagement``: ``Incidents``, ``Employees``  and ``Mitigations``. Each of them has a key called ```ID``` and several other properties. An ``Incident`` has one or more  ``Mitigations`` and, therefore, the property ``IncidentID`` has an association to exactly one ``Incident``. A ``Mitigation`` in turn can be used for one ``Incident``, so it has a “to one” association. The key is automatically filled by the CAP server, which is exposed to the user of the service with the annotation @(Core.Computed : true).

Notice how the CAP server reacted to dropping the file. It now tells you that it has a model but there are no service definitions yet and, thus, it still can’t serve anything. Next, you add a service definition.

1. Create the OData V4 Service

Create a file called ``risk-service.cds`` in the ``srv``

Copy the code here and paste it into the file. 
```js
using { sap.ui.riskmanagement as my } from '../db/schema';
@path: 'service/incident'
service IncidentsService {
  entity Incidents as projection on my.Incidents;
  entity Mitigations as projection on my.Mitigations;
    annotate Mitigations with @odata.draft.enabled;
  entity Employees as projection on my.Employees;
}
```
It creates a new service ``IncidentsService`` in the namespace ``sap.ui.riskmanagement``. This service exposes three entities: Risks, Mitigations & Employees, which are exposing the entities of the database schema you’ve created in the step before.

If you again look at the terminal, you see that the CAP server has noticed the new file and now tells us that it serves something under [http://localhost:4004](http://localhost:4004).

1. In your browser open the link [http://localhost:4004](http://localhost:4004).

<img src="../images/WelcomePage.png" width="500">

4. Choose the ``$metadata`` link.

You see the OData metadata document of your new service. So, with just the two files for the database schema and the service exposure you added to your project, you have already got a running OData service! You might wonder why the service itself is called ``incident`` even though in the file it’s called ``IncidentsService``. This is a convention in CAP, the service suffix is subtracted from the name.

If you now choose the ``Incidents`` link, you only get this:
```js
{
    @odata.context: "$metadata#Incidents",
    value: [ ]
}
```
So, there’s no data yet. This is because so far, your model doesn’t contain any data. You add some now.

1. Create a folder called ``data`` in the ``db`` folder of your app. Now download a local copy of all the csv files from this [github repository](./caprisks/db/data/). Copy the files into the newly created ``data`` folder in your project.  

You have now added three comma-separated value (CSV) files that contain local data for ``Incidents``, ``Mitigations`` and the ``Employees``  entities. A quick look into the ``sap.ui.riskmanagement-Incidents.csv`` (the name consists of your namespace and the name of your database entity from the schema.cds file) file shows data like this:

```csv
ID;createdAt;createdBy;title;prio;descr;impact
20466922-7d57-4e76-b14c-e53fd97dcb11;2023-10-24;max.mustermann@muster.com;Security Breach;3;Unauthorized access to customer data;10000
...
```

The first line contains all the properties from your ``Mitigations`` entity. While the other ones are straight forward, consider the ``ownerEmployee_Id`` property. In your entity, you only have a ``ownerEmployee`` property, so where does it come from? ``ownerEmployee_Id`` is an association to ``Employees``, as ``Mitigations`` could have several key properties, the association on the database needs to point to all of these, therefore the CAP server creates a property ``<AssociationProperty>_<AssociatedEntityKey>`` for each key.

To learn more about composition and associations, check out the [CAP help](https://cap.cloud.sap/docs/cds/cdl#associations)

As always, the CAP server has noticed the changes, you've made.

1. Revisit the ``Incidents`` entity [http://localhost:4004/odata/v4/service/incident/Incidents](http://localhost:4004/odata/v4/service/incident/Incidents) in your browser. You now see the data exposed.

<img src="../images/IncidentsService.png" width="500">

When you revisit the ``Incidents`` entity, you might see something simlar  but not this nicely-formatted JSON output above. This doesn’t mean you have made a mistake in the tutorial. Rather, this is just a formatted output.  There are various chrome/edge extensions to install that will do this for you. 

And that’s it. You now have a full blown OData service, which complies with the OData standard and supports the respective queries without having to code anything but the data model and exposing the service itself. 
