require './sendmail.rb'

to_address = 'hoge@example.com'
from_address = 'fuga@example.com'
file2attach = '/tmp/a.txt'
attach_as = 'piyo.txt.gz' # This sould be "*.gz"
subject = 'attach test'
mail_txt = 'Hello. This is piyo.txt. Enjoy!'
sendmail( to_address, from_address, file2attach, attach_as, subject, mail_txt)

