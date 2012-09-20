# encoding: utf-8
# 
# = EnvelopeRecipient Field
# 
# The To field inherits to StructuredField and handles the To: header
# field in the email.
# 
# Sending to to a mail message will instantiate a Mail::Field object that
# has a ToField as it's field type.  This includes all Mail::CommonAddress
# module instance metods.
# 
# Only one To field can appear in a header, though it can have multiple
# addresses and groups of addresses.
# 
# == Examples:
# 
#  mail = Mail.new
#  mail.envelope_recipient = 'Mikel Lindsaar <mikel@test.lindsaar.net>, ada@test.lindsaar.net'
#  mail.envelope_recipient    #=> ['Mikel Lindsaar <mikel@test.lindsaar.net>', 'ada@test.lindsaar.net']
#  mail[:envelope_recipient]  #=> '#<Mail::Field:0x180e5e8 @field=#<Mail::ToField:0x180e1c4
#  mail['rcpt'] #=> '#<Mail::Field:0x180e5e8 @field=#<Mail::ToField:0x180e1c4
#  mail['RCPT'] #=> '#<Mail::Field:0x180e5e8 @field=#<Mail::ToField:0x180e1c4
# 
#  mail[:envelope_recipient].encoded   #=> 'To: Mikel Lindsaar <mikel@test.lindsaar.net>, ada@test.lindsaar.net\r\n'
#  mail[:envelope_recipient].decoded   #=> 'Mikel Lindsaar <mikel@test.lindsaar.net>, ada@test.lindsaar.net'
#  mail[:envelope_recipient].addresses #=> ['mikel@test.lindsaar.net', 'ada@test.lindsaar.net']
#  mail[:envelope_recipient].formatted #=> ['Mikel Lindsaar <mikel@test.lindsaar.net>', 'ada@test.lindsaar.net']
# 
require 'mail/fields/common/common_address'

module Mail
  class EnvelopeRecipientField < StructuredField
    
    include Mail::CommonAddress
    
    FIELD_NAME = 'rcpt'
    CAPITALIZED_FIELD = 'RCPT'
    
    def initialize(value = nil, charset = 'utf-8')
      self.charset = charset
      super(CAPITALIZED_FIELD, strip_field(FIELD_NAME, value), charset)
      self.parse
      self
    end
    
    def encoded
      do_encode(CAPITALIZED_FIELD)
    end
    
    def decoded
      do_decode
    end
    
  end
end
