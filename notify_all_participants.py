import smtplib
from db import DB
from argparse import ArgumentParser

# The below code never changes, though obviously those variables need values.
def main(recipient,text):
    try:
        session = smtplib.SMTP('smtp.gmail.com', 587)
        session.ehlo()
        session.starttls()
        session.login('clicktionary.ai@gmail.com', 'serrelab')

        email_subject = 'CLICKTIONARY'

        headers = "\r\n".join(["from: " + 'CLICTIONARY',
                       "subject: " + email_subject,
                       "to: " + recipient,
                       "mime-version: 1.0",
                       "content-type: text/html"])

        content = headers + "\r\n\r\n" + text
        session.sendmail('clicktionary.ai@gmail.com', recipient, content)
    except:
        print 'Failed on %s' % recipient

if __name__ == '__main__':
    text='Thank you for playing clickme.ai. We have just started a new contest that will end next Sunday -- we look forward to you playing and seeing your name rise up the leader board towards winning an Amazon gift card.'
    db = DB()
    emails = db.get_emails()
    [main(recipient=em, text=text) for em in emails]
