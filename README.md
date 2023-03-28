# ace-mrm-compile-example
Compiling (deprecated) MRM message sets from the command-line

This repo contains an example MRM message set and an application that uses it, plus a unit
test that runs the key Compute node in the application via the ACE unit test capability.

The application listens on /mrmTest for messages, which are of the form
```
<message1><A1>1</A1><A2>2</A2><A3>3</A3></message1>
```
and are parsed by the MRM parser.

## Getting started

Clone this repo using the ACE 12 toolkit or git command. If using the toolkit, then running
the MRMMessageFlow_Test project (right-click then "Run Test Project") should succeed and all tests
should pass without error.

## Building from the command line

This repo has been tested on Linux and Windows; Windows commands are shown in these examples
but equivalent Linux commands work the same way. While the `mqsicreatebar` command could be 
used for this purpose, `ibmint deploy` is used in this case to avoid requiring the toolkit
to be installed locally.

### Create a work directory
```
C:\Program Files\IBM\ACE\12.0.3.0>mqsicreateworkdir  c:\tmp\mrm-compile-work-dir
mqsicreateworkdir: Copying sample server.config.yaml to work directory
        1 file(s) copied.
Successful command completion.
```

### Compile the application and message set using ibmint
These instructions assume this repo has been cloned to `c:\Users\TrevorDolby\git\ace-mrm-compile-example` 
and should be adjusted accordingly for other locations.
```
C:\Program Files\IBM\ACE\12.0.3.0>ibmint deploy --input-path c:\Users\TrevorDolby\git\ace-mrm-compile-example --output-work-directory c:\tmp\mrm-compile-work-dir
BIP8434I: Compiling message set 'c:\Users\TrevorDolby\git\ace-mrm-compile-example\RecordMRMIssue'
BIP4699I: A dictionary has been generated for the message set at 'c:\Users\TrevorDolby\git\ace-mrm-compile-example\RecordMRMIssue\RecordMRMIssue'.
BIP8409I: Compiling Java project 'c:\Users\TrevorDolby\git\ace-mrm-compile-example\MRMMessageFlow_Test'
BIP15233I: Generating BAR file 'C:\Users\TrevorDolby\AppData\Local\Temp\ibmint_deploy_generated_2022022813-09-13.bar' for deploy.
BIP1859I: Successfully added file 'application.descriptor' to the BAR file.
BIP1859I: Successfully added file 'ControlFlow_Compute.esql' to the BAR file.
BIP1859I: Successfully added file 'HTTPFlow.msgflow' to the BAR file.
BIP1859I: Successfully added file '.GeneratedSchemas\MRMIssue.xsd' to the BAR file.
BIP1859I: Successfully added file '.KeywordsFile\meta-inf\keywords.txt' to the BAR file.
BIP1859I: Successfully added file 'RecordMRMIssue\messageSet.mset' to the BAR file.
BIP1859I: Successfully added file 'RecordMRMIssue\MRMIssue.mxsd' to the BAR file.
BIP1859I: Successfully added file 'RecordMRMIssue.dictionary' to the BAR file.
BIP1859I: Successfully added file 'RecordMRMIssue.xsdzip' to the BAR file.
BIP1859I: Successfully added file 'service.log' to the BAR file.
BIP1859I: Successfully added file 'user.log' to the BAR file.
BIP1853I: Application file 'MRMMessageFlow.appzip' successfully added to the BAR file.
BIP1859I: Successfully added file 'MRMMessageFlow_Test.jar' to the BAR file.
BIP1859I: Successfully added file '0007C122-621CC248-00000001-0.mxml' to the BAR file.
BIP1859I: Successfully added file '0007C122-621CC248-00000001-2.mxml' to the BAR file.
BIP1859I: Successfully added file 'testproject.descriptor' to the BAR file.
BIP8148I: Unpacking BAR file...
BIP8071I: Successful command completion.
```

### Run the unit test to ensure the application is built correctly
```
C:\Program Files\IBM\ACE\12.0.3.0>IntegrationServer -w c:\tmp\mrm-compile-work-dir --test-project MRMMessageFlow_Test
2022-02-28 13:09:44.457272: BIP1990I: Integration server 'mrm-compile-work-dir' starting initialization; version '12.0.3.0' (64-bit)
2022-02-28 13:09:44.515864: BIP9905I: Initializing resource managers.
2022-02-28 13:10:02.330424: BIP9906I: Reading deployed resources.
2022-02-28 13:10:02.349039: BIP9907I: Initializing deployed resources.
2022-02-28 13:10:02.359068: BIP2155I: About to 'Initialize' the deployed resource 'MRMMessageFlow' of type 'Application'.
2022-02-28 13:10:02.393312: BIP2155I: About to 'Initialize' the deployed resource 'MRMMessageFlow_Test' of type 'TestProjectType'.
2022-02-28 13:10:02.715855: BIP9342I: Created compiled 'XMLNSC' schema file 'MRMMessageFlow/RecordMRMIssue.bir'.
2022-02-28 13:10:02.753799: BIP9342I: Created compiled 'XMLNSC' schema file 'MRMMessageFlow/$mqsiApplication.bir'.
2022-02-28 13:10:02.941161: BIP2155I: About to 'Start' the deployed resource 'MRMMessageFlow' of type 'Application'.
An http endpoint was registered on port '7800', path '/mrmTest'.
2022-02-28 13:10:03.023367: BIP3132I: The HTTP Listener has started listening on port '7800' for 'http' connections.
2022-02-28 13:10:03.036452: BIP1996I: Listening on HTTP URL '/mrmTest'.
Started native listener for HTTP input node on port 7800 for URL /mrmTest
2022-02-28 13:10:03.053946: BIP2269I: Deployed resource 'HTTPFlow' (uuid='HTTPFlow',type='MessageFlow') started successfully.
2022-02-28 13:10:08.835129: BIP2866I: IBM App Connect Enterprise administration security is inactive.
2022-02-28 13:10:08.861132: BIP3132I: The HTTP Listener has started listening on port '7600' for 'RestAdmin http' connections.
2022-02-28 13:10:08.871262: BIP9910I: Running tests in test project 'MRMMessageFlow_Test'.
2022-02-28 13:10:09.287      1 STARTING TEST:MRMMessageFlow_HTTPFlow_Compute_TestCase_001()
2022-02-28 13:10:09.411      1 FINISHED TEST:MRMMessageFlow_HTTPFlow_Compute_TestCase_001() SUCCESSFUL
2022-02-28 13:10:09.422      1
TEST RESULTS:
  test.MRMMessageFlow_HTTPFlow_Compute_0001_Test:
    MRMMessageFlow_HTTPFlow_Compute_TestCase_001():SUCCESSFUL

TOTALS:
  PASSED    :1
  FAILED    :0
  ABORTED   :0
  TIME(secs):0.207
2022-02-28 13:10:09.422964: BIP9911I: Running tests in test project 'MRMMessageFlow_Test' completed successfully.
```

## Pipeline

Clone this repo using git, build the projects, and then run them using the IntegrationServer program.
See [build-and-run-tests.sh](build-and-run-tests.sh) for a script that shows the sequence of commands.

### Codespaces (experimental)

This repo can be run in a container via GitHub codespaces, which are a feature of GitHub that enables 
container-based development with VisualStudio Code in a web browser. The container in which vscode
runs is configurable, and this repo uses a container with ACE installed.

Developers get sixty hours of container runtime for free (at the time of writing), and a codespace can be launched from the "Code" menu:

![Codespaces launch](/.devcontainer/codespaces-launch.png)

The container will start up once the image has been downloaded (usually 100-150 seconds)
and vscode will start automatically. All of the usual ACE commands are present, servers
can be started as usual, etc. Running
```
./build-and-run-tests.sh
```
in the terminal will build and run the various tests for the projects.

This repo is configured to use an ACE devcontainer that can run the toolkit in a browser 
session; see https://github.com/trevor-dolby-at-ibm-com/ace-vnc-devcontainer for details on
how to access the toolkit.

### OpenShift Dev Spaces (experimental)

This repo can be run in a container via OpenShift Dev Spaces, which are a feature of OpenShift
that enables container-based development with VisualStudio Code in a web browser. The container
in which vscode runs is configurable, and this repo is configured to use an ACE devcontainer
that can run the toolkit in a browser session; see https://github.com/trevor-dolby-at-ibm-com/ace-dev-spaces-container
for details on how to build/run the container images and access the toolkit.
