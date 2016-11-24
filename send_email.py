import smtplib

# The below code never changes, though obviously those variables need values.
session = smtplib.SMTP('smtp.gmail.com', 587)
session.ehlo()
session.starttls()
session.login('drew_linsley@brown.edu', 'gwmaa24309w4')

email_subject = 'test'
recipient = 'drewlinsley@gmail.com'

headers = "\r\n".join(["from: " + 'serre.lab',
                       "subject: " + email_subject,
                       "to: " + recipient,
                       "mime-version: 1.0",
                       "content-type: text/html"])

content = headers + "\r\n\r\n" + 'train your model'
session.sendmail('drew_linsley@brown.edu', recipient, content)
