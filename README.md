# A simple API
This API is built using Azure Function Apps. Each Function within the Function App can be used as a HTTP endpoint for your API. Authentication is performed via Azure Active Directory (AAD), which supports authorization using Azure role-based access control (RBAC). Application Insights is used to store and visualize metrics and logs of the Function App. For production logging, the "Information" level has been set in *./functions/host.json* however this file is ininitalized after the Functions are created. A Web Application Firewall is used with Azure Front Door to provide DDoS protection for the Function App. 

A sample set of functions are included in this repo in the *./functions* folder to demonstrate the CRUD capabilities of the Function App.

## Deployment instructions
1. Create an App Registration in Azure Active Directory
   Navigate to Azure Active Directory > App registration and create a new registration.
2. Deploy ARM template 
   On the Azure search bar (at the top of the page), select "Deploy a custom template". Select "Build your own template in the editor", and enter the contents of *main.json*. Select/create a resource group. Select "Edit parameters", enter the contents of *main.parameters.json*, and set the parameters accordingly. The *aadClientId* field is set to the App Registration client ID from the previous step. Review and deploy.
3. Register the Function App in the App Registration.
   After the deployment is complete, navigate to the Authentication tab in the App Registration. Select "Add a platform" > "Single-page application" and set the redirect uri as "https://**[function app name here]**.azurewebsites.net/.auth/login/aad/callback". Ensure that "Access tokens" and "ID tokens" are selected.
4. Create functions by navigating to the function app > Functions > Add and select HTTP trigger. Ensure that the Authorization level is set to "Anonymous" as the authorization will be provided by AAD.

## Troubleshooting
Ensure that the resource group has no existing resources from a previous deployment (even failed ones) by deleting the resources created. Ensure that the hidden resources are also removed on deletion (done by navigating to the resource group, selecting the "Show hidden types" option and deleting the resources)
