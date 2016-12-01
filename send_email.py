import smtplib
from argparse import ArgumentParser

# The below code never changes, though obviously those variables need values.
def main(recipient,text):
    session = smtplib.SMTP('smtp.gmail.com', 587)
    session.ehlo()
    session.starttls()
    session.login('clicktionary.ai@gmail.com', 'serrelab')

    email_subject = 'CLICKTIONARY'
    #recipient = 'drewlinsley@gmail.com'

    headers = "\r\n".join(["from: " + 'CLICTIONARY',
                       "subject: " + email_subject,
                       "to: " + recipient,
                       "mime-version: 1.0",
                       "content-type: text/html"])

    content = headers + "\r\n\r\n" + text
    session.sendmail('clicktionary.ai@gmail.com', recipient, content)

if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument("--recipient", type=str, dest="recipient",
        default='drewlinsley@gmail.com', help="recipient.")
    parser.add_argument("--text", type=str, dest="text",
        default='train your model', help="email text.")
    args = parser.parse_args()
    main(**vars(args))
