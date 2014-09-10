# coding: utf-8
class AnnounceMailer < ActionMailer::Base
	default :from => "noreply@nttcloud.net", :to => Hoge::Application.config.to_address
  def ack_email(announce)
    @announce = announce
		@toaddr = @announce.mail.split(",")
		mail(:to => @ccaddr, :subject => "Announce has registered.")
  end

  def delete_mail(announce)
    @announce = announce
		if @announce.mailid.present?
			headers['In-Reply-To'] = @announce.mailid
		end

		@ccaddr = @announce.mail.split(",")
    headers['Message-ID'] = "<#{ UUID.generate }@nttcloud.net>"
    mail(:cc => @ccaddr, :subject => "Your announce is deleted")
  end
  
  def start_mail(announce)
    @announce = announce
    if @announce.mailid.present?
      headers['In-Reply-To'] = @announce.mailid
    end

		# Insert LineFeed

		@announce.mailid = "<#{ UUID.generate }@nttcloud.net>"
		headers['Message-ID'] = @announce.mailid
		@ccaddr = @announce.mail.split(",")
    mail(:cc => @ccaddr, :subject => MAIL_SUBJ_START+@announce.title)
  end

  def report_mail(announce, message)
    @announce = announce
		@message = message
    @announce.mailid = "<#{ UUID.generate }@nttcloud.net>"
    headers['Message-ID'] = @announce.mailid
    @ccaddr = @announce.mail.split(",")
#    mail(:cc => @ccaddr, :subject => "[Work Announce]"+@announce.title)
    mail(:cc => @ccaddr, :subject => MAIL_SUBJ_REPORT+@announce.title)
  end



	def finish_mail(announce, message)
		@announce = announce
		@message = message

		if @announce.mailid.present?
			headers['In-Reply-To'] = @announce.mailid
		end

    @announce.mailid ="<#{ UUID.generate }@nttcloud.net>"
		headers['Message-ID'] = @announce.mailid
		@ccaddr = @announce.mail.split(",")
		mail(:cc => @ccaddr, :subject => MAIL_SUBJ_FINISH+@announce.title)
	end
end
