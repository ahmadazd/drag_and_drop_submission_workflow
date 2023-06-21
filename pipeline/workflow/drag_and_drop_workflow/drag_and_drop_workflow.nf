// See the NOTICE file distributed with this work for additional information
// regarding copyright ownership.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
nextflow.enable.dsl=2

//default params
params.help = false

// mandatory params
params.spreadsheet = null
params.webin_account = null  
params.webin_password = null
params.action = null
params.xml_output = null
params.context = null
params.files_dir = null
params.mode = null
params.webinCli_dir = null


// Print usage
def helpMessage() {
  log.info """
        Usage:
        The typical command for running the pipeline is as follows:
        nextflow run dh_mangment_workflow.nf --datahub_name <DATAHUB NAME> --datahub_password <DATAHUB PASS> --action <FULL/LINK/MODIFY>"

        Mandatory arguments:
        --spreadsheet                    The absolute path for the spreadsheet file (Retrieved from the nextflow.config file)
        --webin_account                  The user webin account
        --webin_password                 The password of the webin account 
        --action                         action to submit the metadata (add or modify) (Retrieved from the nextflow.config file)
        --xml_output                     The output of the metadata xml files (Retrieved from the nextflow.config file)
        --context                        Type of files
        --files_dir                      The absolute path for the files
        --mode                           The type of the submission mode (submit or validate) (Retrieved from the nextflow.config file)
        --webinCli_dir                    The absolute path for the webin-cli file directory

        Optional arguments:
        --help                         This usage statement.
        """
}

// Show help message
if (params.help) {
    helpMessage()
    exit 0
}

assert params.spreadsheet, "Parameter 'spreadsheet' is not specified"
assert params.webin_account, "Parameter 'webin_account' is not specified"
assert params.webin_password, "Parameter 'webin_password' is not specified"
assert params.action, "Parameter 'action' is not specified"
assert params.xml_output, "Parameter 'xml_output' is not specified"
assert params.context, "Parameter 'context' is not specified"
assert params.files_dir, "Parameter 'files_dir' is not specified"
assert params.mode, "Parameter 'mode' is not specified"
assert params.webinCli_dir, "Parameter 'webinCli_dir' is not specified"

// Import modules/subworkflows
include { subworkflow } from '../../subworkflow/subworkflow.nf'

// Run main workflow
workflow {
    main:
    subworkflow(params.spreadsheet, params.webin_account, params.webin_password, params.action, params.xml_output, params.context, params.files_dir, params.mode, params.webinCli_dir)
}