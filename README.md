# drag_and_drop_submission_workflow
metadata_submission command to run standalone  
` python3 metadata_submission.py -f <spreadsheet_dir> -u <Webin-####> -p <'password'> -a add -t -o <output_dir>`

bulk_webincli command to run standalone
` python3 bulk_webincli.py -s <spreadsheet_dir> -d <files_dir> -m <mode(submit/validate)> -u <Webin-####> -p <'password'> -g <context> -w <webin_cli software directory>`

nextflow pipeline command to run
` nextflow run pipeline/workflow/drag_and_drop_workflow/drag_and_drop_workflow.nf  --webin_account <webin account id> --webin_password <webin account password>  --context <reads/genome> --mode <validate/submit> --senderEmail_password <email password> --uuid <uuid>`

Add the `<sender_email>` and `<rec_email>` value in the `nextflow.config` file

files directory: contains the files to be submitted (contains four fastq files for testing)

output directory : contains the metadata_submission outputs ((experimental_spreadsheet)) and log files

webin-cli directory : contains the webin_cli software

spreadsheets directory : contains the metadata spreadsheet (contains two template spreadsheets)

### NOTE: before running the Nextflow workflow run the following command (the first time only)

`pip install -e .`


