#!/usr/bin/env nextflow

nextflow.enable.dsl=2 
//assigner_dir = "/scratch"

process EMAILER {
	tag "emailer"                  
	label 'default'                
	//temp = "/temp"                
	//publishDir "/temp", mode: 'copy' 

input:
    val emailPass
    path config
    path log_dir

output:
	stdout

    """
    Email sent successfully!
    """

script:
 """
 emailer --emailPass $emailPass --config $config --log $log_dir
 """
 }
 
 
workflow {
  EMAILER_CH = EMAILER(params.emailPass, params.config, params.log_dir)
}