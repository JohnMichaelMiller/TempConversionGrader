## Juxce

## The Problem
Our users are science teachers who are comfortableusing the command line, a ReST API, or abrowser. In their “Unit Conversion” science unit, they want to assign students unit-conversion problems on paper worksheets. After students turnin their completed worksheet, the teachers want to be able to enter the questions and student responses into a computer to be graded. Students will convert: temperatures between Kelvin, Celsius, Fahrenheit, and Rankine (From the doc)

## Approach
The general approach was to write the temperature conversion function and it's PtP up and running consistently. Then to create test for the conversion grader and those tests to pass following the TDD approach. The initial commit of the conversion grade tests is sha 788f8d76797f0674f2ec42687177a8a4df20b780. Prior to this commit the PtP was green and the temperature conversion function was working in production. This commit broke the build.
#### #DD: -1 Approach, further elaboration is warranted

## Architecture
#### Application Architecture
The application architecure is serverless functions deployed into an Azure Function App. The solution is entirely PaaS and there is no IaaS utilized. 

This architecture was chosen for two reasons. 
1. It's the simpilist thing that could possibly work
2. It's cheap

#### Pipeline Architecture
The pipeline is implemented in Azure Pipelines which as support for the application architecture and both the GitHub source repo and the Azure cloud platform. The pipeline is run on Linux agents.
#### #DD: -2 Architecture; Application Architecture; Pipeline Architecture, Further elaboration is warranted.

## PtP
The entire path to production is implemented in the azure-pipelines.yml file. This file is recogined by Azure pipelines and allows the entire pipeline to represented in code. It consists of combination of native Azure Pipelines tasks, third party extensions to Azure pipelines, inline powershell, and powershell code files.

The pipeline is continuous deployment. Any commit to main will follow the path and be deployed to production.

During the swap from staging to production there is a small service disruption of between 1-2 seconds and a slightly longer disruption of 2-3 seconds durning the update of the function app. This can be demonstrated by running the AvailabilityTest again production while the pipeline is running. As zero-downtime was not called out in the requirements I didn't spend any effort trying to eliminate these short disruptions.

### Test Automation
The pipeline makes extensive use of test automation to protect production from defects. There are unit, provisioning, integration and availability tests. In addition to protecting production from bad code, the test automation allows much of development to occur locally. A local.ps1 file is setup to run all of the test automation and can be filtered with tags. 

Unit test make use of Mocks to isolate dependencies. The unit tests take advantage of PowerShell classes to mock objects related to the HTTP requests.

Provisioning tests provision resources in a test resource group to ensure that the provisioning logic is sound. The integration tests run in a staging environment and verifty that the functions are deployed and working before allowing new versions into production. 

Of particular note is the use of a test framework to implement the provisioning logic. This provides three benefits:
1. It simplifies the provisioning code. There is very little logic in the provisioning code.
2. The framework intrisically supports verifying that provisioning is successful immediately after the resource is provisioned.
3. The output of the provisioning code is cleaner. This along with the clean code makes the provision code easier to maintain.
#### #DD: -3 PtP Further elaboration based on feedback

## Development and Testing
The TemperatureConversion function was developed by writing the conversion logic and then the test automation to show that it worked. Then the PtP was built one stage at a time until the function was deployed to production and working. Next test automation was retrofitted against the code supporting the path to production. With Test automation in place, adding the ConversionGrader function was much more straight forward. The TemperatureConversion Function was clone and all references to TemperatureConversion renamed. The implementation code was stubbed out so that it would run but did not contain an implementation. The test automation was then refactored with the requirements for grading in mind until all of the tests ran and failed. 
Now the implementation could begin by running each and implementing the code need to get the tests to pass. This often required changes to the tests as well as it wasn't possible to predict exactly what the inpouts and outputs would be. Once all the tests, with the exception of the integration tests were green when run locally, I pushed these changes to main and the pipeline stayed green all the way to the integration tests which is the last gate before going live.
With the code successfully deployed to staging, the imtegration tests could be cleaned up locally and once green, pushed to main. This trigger a build that went green all the way to production.
## Installation
To get the solution deployed there are several bot strap steps.
* Azure Subscription
    * Azure Default Resource Groups
* Azure DevOps Project
    * Azure DevOps Service Connections
        * Azure
        * GitHub

This may not be comprehensive. There is a tech debt item to document and automate all of the boot straps actions.
### Cost 
The choice of serverless, service plan used, and the lack of persistent data makes this solution very cheap to operate. Current cost are forecasted at $0.05 per month. Also, scale was not a consideration and ther services are running single instances.  
### Running
The endpoint for the temperature conversion service is https://Juxcefunctionapp.azurewebsites.net/api/TemperatureConversionFunction. The conversion grader has a dependency on this function.

The following query parameters are supported:
InputValue - Any decimal number
OutputUnit - Valid input units are Fahrenheit, Celsius, Kelvin, and Rankine
InputUnit - Valid output units are the same as the input units

The function returns the input values and the coverted result in the body of the response.

Example: https://Juxcefunctionapp.azurewebsites.net/api/TemperatureConversionFunction?InputValue=6.5&OutputUnit=Rankine&InputUnit=Fahrenheit

The endpoint for the conversion grader service is https://Juxcefunctionapp.azurewebsites.net/api/ConversionGraderFunction.

The following query parameters are supported:
InputValue - Any decimal number
OutputUnit - Valid input units are Fahrenheit, Celsius, Kelvin, and Rankine
InputUnit - Valid output units are the same as the input units
StudentValue - Any decimal number

The function returns the input values and the grade in the body of the response.

Example: https://Juxcefunctionapp.azurewebsites.net/api/ConversionGraderFunction?InputValue=84.2&InputUnit=Fahrenheit&OutputUnit=Rankine&StudentValue=543.94

## Technical Debt
While the goal is a cloud ready solution, there is still much to do. Debt is anything that should be done. I've identified three types: Feature Debt (FD) which are changes that would affect users. Technical Debt (TD) which are changes that don't directly impact users but improve NFRs. Documentation Debt (DD) which are improvements to the documentation to make the project easier to understand.

Changes that are project wide are listed below. Changes that only affect a portion of the solution are inserted as comments in the relevant source. One TD item is to scan the project for these debt markers, create work items to track the resolution of the debt. Ideally the scan would part of the PtP and the markes in the source updated with links to the work items.
#### #DD: -4 Technical Debt, further elaboration might be needed.
#### #TD: -1 Green-Light Pipeline that makes the call on when it's ok to proceed with the swap; 
#### #TD: -2 Pipeline for DevSecOps? 
#### #TD: -3 Pipeline for Docs
#### #TD: -4 Pipeline for Data
#### #TD: -5 Pipeline for Performance
#### #TD: -6 Pipeline for Scale
#### #TD: -7 Pipeline for Resiliency
#### #TD: -8 Provisioning Pipeline for GCP
#### #TD: -9 Provisioning Pipeline for AWS
#### #TD: -10 Implementation for GCP
#### #TD: -11 Implementation for AWS
#### #TD: -12 Provision DNS for production and staging
#### #TD: -14 Capture and automate bootstrap steps need to get the pipeline up and running in a different subscription
#### #TD: -15 Should Application code be sperated from provisioning and deployment?
#### #TD: -16 Implement health checks


## Feature Debt
#### #TD: -13 Generate FD from #WIs
#### #FD: -1 Capture student’s numeric response and include evaluation of the student's value with the correct coverted value and return an idication of the correctness of the value.If the student's response is within .015 of the actual value the student's response is considered correct.
#### #FD: Create a web form as an alternate method for providing data
#### #FD: Support the uploading of a markdown file containing a table of data to be graded and return a table with the grades.


## Code Review Guidance and Instances
#### #DD: -6 Code Review Guidance and Instances

## PR Guidance
#### #DD: -7 PR Guidance

## Glossary
- PtP is Path-to-Production and includes all of the Stages, Jobs, and Steps involved in getting from the push of change to the main branch through to the release of the change for use.
- WI is work item in Azure DevOps
- WI#s is work item numbers or work item number's depending on the context
- #TD: is a marker for technical debt
- #DD: is a marker for documention debt
- #FD: is a marker for feature debt 

Thank you for your attenion. FWIW, no prior work was consulted in the creation of thes solution, with the exception of typical reference sources that one would beexpected to consult. 

This respository represents the orginal work of the committers and is copywrighted per the LICENSE file.

