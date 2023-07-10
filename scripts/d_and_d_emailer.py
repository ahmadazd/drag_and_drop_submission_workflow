#!/usr/bin/env python3
import smtplib # Simple Mail Transfer Protocol
import argparse
from argparse import RawTextHelpFormatter
import os
import fnmatch

description = """
TO DO
"""

example = """
Example:
    TO DO
"""


parser = argparse.ArgumentParser(description=description, epilog=example, formatter_class=RawTextHelpFormatter)


parser.add_argument('-ld1', '--logdir_1', help='path to directory where all receipt XML log files are kept', type=str, required=True) # /mnt/c/Users/zahra/Documents/scripts/Python/drag_and_drop_submission_workflow/output/logs
parser.add_argument('-ld2', '--logdir_2', help='path to directory where Webin-CLI report log file is kept', type=str, required=True) # /mnt/c/Users/zahra/Documents/scripts/Python/drag_and_drop_submission_workflow/files/submissions
parser.add_argument('-s', '--sender_email', help='email address of sender', type=str, required=True) # password input is that of sender email
parser.add_argument('-r', '--rec_email', help='email address of recipient', type=str, required=True) # email will be sent here

args = parser.parse_args()



# TODO: emailer function


# Argument variables
sender_email = f'{args.sender_email}' # virus-dataflow@ebi.ac.uk? # "z_w_test123@hotmail.com"
rec_email = f'{args.rec_email}' # B101nf0rm4t1cs123! # "zahra.w@hotmail.co.uk"
password = input(str("Please enter your password: ")) # password of sender email account
server = smtplib.SMTP("outgoing.ebi.ac.uk", 587) # EBI host running SMTP server


# Set up connection
try:
    smtp = smtplib.SMTP("smtp-mail.outlook.com", 587) # according to email client
    smtp.starttls()  # TLS for security
    smtp.login(sender_email, password)
    print("Login success")

    # Construct emails
    subject = 'Drag and Drop Submission Status:'  # TODO: specify UUID in subject header?

    for logf_1 in os.listdir(f'{args.logdir_1}'): #logdir_1 outputs only 1 file (i.e logf) per run, #logdir_2 outputs multiple files (incl. 1 logf) per run
        with open(f'{args.logdir_1}/{logf_1}', 'r') as tfile_1:
            body1 = tfile_1.read()
            print(tfile_1.read())

        # TODO: content text below needs to be laid out better  # TODO: add pass or fail statement to top of email based on txt file contents
        content = \
            '-----------------------------------------' \
            '     Study/Sample submission receipt     ' \
            '-----------------------------------------' \
            '\n\n' + str(body1)

        mail_text = 'Subject:' + subject + '\n\n' + content # to fix 'ascii' codec can't encode character '\xb5' in position 572: ordinal not in range(128) error
        print(mail_text)

        # Send emails
        smtp.sendmail(sender_email, rec_email, mail_text.encode('utf-8'))
        print("email has been successfully sent to: ", rec_email)

    for logf_2 in os.listdir(f'{args.logdir_2}'):
        if fnmatch.fnmatch(logf_2, '*log_total*'):
            with open(f'{args.logdir_2}/{logf_2}', 'r') as tfile_2:
                body2 = tfile_2.read()
                print(tfile_2.read())

            content = \
                '-----------------------------------------' \
                '        Webin-CLI submission receipt     ' \
                '-----------------------------------------' \
                '\n\n' + str(body2)

            mail_text = 'Subject:' + subject + '\n\n' + content
            print(mail_text)

            # Send emails
            smtp.sendmail(sender_email, rec_email, mail_text.encode('utf-8'))
            print("email has been successfully sent to: ", rec_email)

except Exception as e:
    print(f'\nERROR with sending emails: {e}\n' \
          'Verify that the SMTP settings are correct')







#------
# Construct message
# def build_email(study_sample_dir, webin_dir): #accepts 2 log_dir arguments
#     subject = 'Drag and Drop Submission Status:'  # TODO: specify UUID in subject header?
#
#     for logf_1, logf_2 in zip(os.listdir(study_sample_dir), os.listdir(webin_dir)):
#         if webin_dir:
#             if fnmatch.fnmatch(logf_2, '*log_total*'):
#                     with open(f'{webin_dir}/{logf_2}', 'r') as webin_log:
#                         body = webin_log.read()
#                         print(webin_log.read())
#         elif study_sample_dir:
#             with open(f'{study_sample_dir}/{logf_1}', 'r') as study_sample_log:
#                 body = study_sample_log.read()
#                 print(study_sample_log.read())
#     return
#
# build_email(f'{args.logdir_1}', f'{args.logdir_2}')

