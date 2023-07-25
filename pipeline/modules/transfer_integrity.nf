#!/usr/bin/env nextflow

nextflow.enable.dsl=2 

process TRANSFER_INTEGRITY {
	tag "transfer_integrity"                  
	label 'default'                
	//publishDir "$log_dir", mode: 'copy' 

input:
	val uuid
	path transfer_output // optional input value? user specified output dir


output:
	path "$transfer_output/transfer_integrity_output/input_spreadsheet", emit: spreadsheet_dir // path to user metadata spreadsheet
	path "$transfer_output/transfer_integrity_output/pass", emit: dataFiles_dir// path to pass data files folder


script:
if ( params.transfer_output) {
 """
echo transferring files to user specified output directory

transfer -u $uuid -o $transfer_output
 """
 }
 
else {
 """
echo transferring files to default codon location

transfer -u $uuid
 """
 }}
 
workflow {
   TRANSFER_INTEGRITY_CH = TRANSFER_INTEGRITY(params.uuid, params.transfer_output) //optional outdir parameter?
}
