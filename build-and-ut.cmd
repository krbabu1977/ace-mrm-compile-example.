REM
REM This script automates the building and testing of the MRM message set and flows.
REM
REM Copyright (c) 2023 Open Technologies for Integration
REM Licensed under the MIT license (see LICENSE for details)
REM 

REM Create the work directory
call mqsicreateworkdir %TEMP%\ace-mrm-compile-example-work-dir

REM ibmint new for v12
ibmint deploy --input-path . --output-work-directory %TEMP%\ace-mrm-compile-example-work-dir --project MRMMessageFlow --project RecordMRMIssue --project MRMMessageFlow_Test

REM Run the server to run the tests
IntegrationServer -w %TEMP%\ace-mrm-compile-example-work-dir --start-msgflows false --no-nodejs --admin-rest-api -1 --test-project MRMMessageFlow_Test
