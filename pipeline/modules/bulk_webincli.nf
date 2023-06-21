#!/usr/bin/env nextflow

nextflow.enable.dsl=2 

process BULK_WEBINCLI {
	tag "bulk_webincli"                  
	label 'default'                

input:
	path spreadsheet
	val webin_account 
	val webin_password
    val context
    path files_dir
    val mode
    path webinCli_dir

output:
	path "$files_dir/submissions/webin-cli.report"
	//path $log_dir // this is needed to link the log file timing to the emailer process, means to start the emailer process after finishing the bulk_webincli process (check if this possible in this way)


script:
 """
 bulk_webincli -s $spreadsheet -u $webin_account -p $webin_password -g $context -d $files_dir -m $mode -w $webinCli_dir
 """
 }
 
 
workflow {
   BULK_WEBINCLI = ASSIGNER(params.spreadsheet, params.webin_account, params.webin_password, params.context, params.files_dir, params.mode, params.webinCli_dir).view()
}
