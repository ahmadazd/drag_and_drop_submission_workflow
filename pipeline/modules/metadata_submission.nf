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
	env environment


output:
	path "$output/experimental_spreadsheet.xlsx", emit: spreadsheet_log, optional: true
	path "$output/logs", emit: metadata_log

script:
if ( params.environment.toLowerCase() == 'test') {
	"""
	metadata_submission -f $spreadsheet -u $webin_account -p $webin_password -a $action -o $output -t
	"""
 }

 else if (params.environment.toLowerCase() == 'prod' || params.environment.toLowerCase() == 'production') {
	"""
	metadata_submission -f $spreadsheet -u $webin_account -p $webin_password -a $action -o $output
	"""
 }
 
}
workflow {
   METADATA_SUBMISSION_CH = METADATA_SUBMISSION(params.spreadsheet, params.webin_account, params.webin_password, params.action, params.output, params.environment)
}
