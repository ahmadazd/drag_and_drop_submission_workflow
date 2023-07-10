#!/usr/bin/env nextflow

nextflow.enable.dsl=2 

process TRANSFER_INTEGRITY {
	tag "transfer_integrity"                  
	label 'default'                
	//publishDir "$log_dir", mode: 'copy' 

input:
	val uuid
	path output_dir // optional input value? user specified output dir


output:
	path $spreadsheet // path to user metadata spreadsheet
	path $pass_files_dir // path to pass data files folder


script:
if ( params.output ) {
 """
echo transferring files to user specified output directory

transfer_integrity_check.py -u $uuid -o $output
 """
 }
 
else {
 """
echo transferring files to default codon location

transfer_integrity_check.py -u $uuid
 """
 }
 
workflow {
   TRANSFER_INTEGRITY_CH = TRANSFER_INTEGRITY(params.uuid).view() //optional outdir parameter?
}
