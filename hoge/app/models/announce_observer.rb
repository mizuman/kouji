class AnnounceObserver < ActiveRecord::Observer
  def after_save(announce)
#    AnnounceMailer.ack_email(announce).deliver
  end
end
