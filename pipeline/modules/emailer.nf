#!/usr/bin/env nextflow

nextflow.enable.dsl=2 
//assigner_dir = "/scratch"

process EMAILER {
	tag "emailer"                  
	label 'default'                
	//temp = "/temp"                
	//publishDir "/temp", mode: 'copy' 

input:
	path logdir_1
	path logdir_2
	val sender_email
	val rec_email
	val password

output:
	stdout

    """
    Email sent successfully!
    """

script:
 """
/mnt/c/Users/zahra/Documents/scripts/Python/drag_and_drop_submission_workflow/scripts/d_and_d_emailer.py --logdir_1 $logdir_1 --logdir_2 $logdir_2 --sender_email $sender_email --rec_email $rec_email --password $password
 """
 }
 
 
workflow {
  EMAILER_CH = EMAILER(params.logdir_1, params.logdir_2, params.sender_email, params.rec_email, params.password)
}
