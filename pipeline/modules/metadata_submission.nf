#!/usr/bin/env nextflow

nextflow.enable.dsl=2 

process METADATA_SUBMISSION {
	tag "metadata_submission"                  
	label 'default'                
	//publishDir "$log_dir", mode: 'copy' 

input:
	path spreadsheet
	val webin_account 
	val webin_password
    val action
	path output


output:
	path "$output/experimental_spreadsheet.xlsx"
	//path $log_dir // this is needed to link the log file timing to the emailer process, means to start the emailer process after finishing the metadata_submission process (check if this possible in this way)

script:
 """
 metadata_submission -f $spreadsheet -u $webin_account -p $webin_password -a $action -o $output -t
 """
 }
 
 
workflow {
   METADATA_SUBMISSION_CH = METADATA_SUBMISSION(params.spreadsheet, params.webin_account, params.webin_password, params.action, params.output).view()
}
