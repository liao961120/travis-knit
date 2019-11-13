import csv, smtplib, ssl
from email.mime.text import MIMEText
from email.header import Header
import os
from os.path import isfile, isdir, join
import sys
#print(sys.argv[1:])

# Specify colnames
message = sys.argv[1]  #input('Email content > ')  
email = sys.argv[2] #input('Send email to > ')
gmail_password = sys.argv[3] #input('Gmail password > ')

print(email, gmail_password)
# 寄信函數
def sendmail(toEmail, message, gmail_password):
    gmail_user = 'yfliao1996@gmail.com'
    #gmail_password = '' # your gmail password

    msg = MIMEText(message, 'plain', "utf-8")
    msg['Subject'] = 'Auto knit HTML on Travis-CI'
    msg['From'] = gmail_user
    msg['To'] = toEmail

    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    server.ehlo()
    server.login(gmail_user, gmail_password)
    server.send_message(msg)
    server.quit()

    print(f'Email sent to {toEmail}')


# Send Email
try:
    sendmail(email, message, gmail_password)
    print(email, message)
except:
    failed.append(f'failed to sent to {email}')
