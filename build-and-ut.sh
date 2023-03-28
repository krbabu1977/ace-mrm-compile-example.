#!/bin/bash
#
# This script automates the building and testing of the MRM message set and flows.
#
# Copyright (c) 2023 Open Technologies for Integration
# Licensed under the MIT license (see LICENSE for details)
#

# Create the work directory
mqsicreateworkdir /tmp/ace-mrm-compile-example-work-dir

# Old commands 
#mqsipackagebar -w . -a /tmp/MRMMessageFlow.bar -k MRMMessageFlow -t MRMMessageFlow_Test
#mqsibar -c -w /tmp/ace-mrm-compile-example-work-dir -a /tmp/MRMMessageFlow.bar

# ibmint new for v12
ibmint deploy --input-path . --output-work-directory /tmp/ace-mrm-compile-example-work-dir --project MRMMessageFlow --project RecordMRMIssue --project MRMMessageFlow_Test

# ibmint optimize server new for v12.0.4
ibmint optimize server --work-directory /tmp/ace-mrm-compile-example-work-dir

# Run the server to run the tests
IntegrationServer -w /tmp/ace-mrm-compile-example-work-dir --mq-queue-manager-name dummy --start-msgflows false --no-nodejs --admin-rest-api -1 --test-project MRMMessageFlow_Test
