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

// Import modules/subworkflows
include { METADATA_SUBMISSION } from '../modules/metadata_submission.nf'
include { BULK_WEBINCLI } from '../modules/bulk_webincli.nf'
//include { EMAILER } from '../modules/emailer.nf' //to link the emailer.nf

workflow subworkflow { //emailer.nf parameters needs to be added here
    take:
        spreadsheet
	    webin_account  
	    webin_password
        action
        xml_output
        context
        files_dir
        mode
        webinCli_dir

    emit:
    metadata_submission_ch
    bulk_webincli_ch
    //metadata_emailer_ch
    //bulkWebinCli_emailer_ch

    main:
        metadata_submission_ch = METADATA_SUBMISSION(spreadsheet, webin_account, webin_password, action, xml_output).view()
        bulk_webincli_ch = BULK_WEBINCLI(metadata_submission_ch, webin_account, webin_password, context, files_dir, mode, webinCli_dir).view()
        //metadata_emailer_ch = EMAILER(emailPass, config, metadata_submission_ch[1])//This for the emailer process to link it with metadata_submission process (check if the [1] index works in this case)
        //bulkWebinCli_emailer_ch = EMAILER(emailPass, config, bulk_webincli_ch[1])// This for the emailer process to link it with bulk_webincli process (check if the [1] index works in this case)
}

workflow {
    subworkflow(params.spreadsheet, params.webin_account, params.webin_password, params.action, params.xml_output, params.context, params.files_dir, params.mode, params.webinCli_dir) //emailer parameters needs to be added here
}
