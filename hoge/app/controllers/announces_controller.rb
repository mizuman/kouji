# coding: utf-8
class AnnouncesController < ApplicationController
	respond_to :html, :json

  # GET /announces
  # GET /announces.json
  def index
    @announces = Announce.not_finished.order("stime DESC")
		@pannounces = Announce.finished.last_24_hours.limit(20).order("etime DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @announces }
    end
  end

  # GET /announces/1
  # GET /announces/1.json
  def show
    @announce = Announce.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @announce }
    end
  end

  # GET /announces/new
  # GET /announces/new.json
  def new
    @announce = Announce.new
		@type = params[:type]
		
		if @type == "fw" then
			@announce.title  = FW_TITLE
			@announce.device = FW_DEVICE 
			@announce.message = FW_MESSAGE
		elsif @type == "mac" then
			@announce.title = MAC_TITLE
			@announce.device = MAC_DEVICE
 			@announce.message = MAC_MESSAGE
		elsif @type == "room" then
			@announce.title = ROOM_TITLE
			@announce.message = ROOM_MESSAGE
		end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @announce }
    end
  end

  # GET /announces/1/edit
  def edit
    @announce = Announce.find(params[:id])
  end

  # POST /announces
  # POST /announces.json
  def create
    @announce = Announce.new(params[:announce])

    respond_to do |format|
      if @announce.save
        format.html { redirect_to @announce, notice: 'Announce was successfully created.' }
        format.json { render json: @announce, status: :created, location: @announce }
      else
        format.html { render action: "new" }
        format.json { render json: @announce.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /announces/1
  # PUT /announces/1.json
  def update
    @announce = Announce.find(params[:id])

    respond_to do |format|
      if @announce.update_attributes(params[:announce])
        format.html { redirect_to @announce, notice: 'Announce was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @announce.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announces/1
  # DELETE /announces/1.json
  def destroy
    @announce = Announce.find(params[:id])
    @announce.destroy
    #AnnounceMailer.delete_mail(@announce).deliver

    respond_to do |format|
      format.html { redirect_to announces_url }
      format.json { head :no_content }
    end
  end

  # /announces/1
  def start
    @announce = Announce.find(params[:id])
    AnnounceMailer.start_mail(@announce).deliver

		@announce.state_id = 1
		
		@announce.update_attributes(params[:announce])
		respond_with(@announce)
  end

	def report
		@announce = Announce.find(params[:id])
	end

	def result
		@announce = Announce.find(params[:id])
		@action = params[:aname]
		@message = params[:message]

		if @action == "report" then
			AnnounceMailer.report_mail(@announce, @message).deliver
		elsif @action == "finish" then
			AnnounceMailer.finish_mail(@announce, @message).deliver
			@announce.state_id = 3
		end

		@announce.update_attributes(params[:announce])
		respond_to do |format|
			if @action == "report" then
				format.html { render :action => :result }
			elsif @action == "finish" then
				format.html { render :action => :finish }
			end
		end
	end

	def finish
		@announce = Announce.find(params[:id])
		respond_to do |format|
			format.html { render :action => :report }
		end
	end

	def log
		@search = Announce.search(params[:search])
		@announces = @search.order("stime DESC").finished.page(params[:page]).per(10)
#		@announces = Announce.finished.order("stime DESC").page(params[:page]).per(10)
		respond_to do |format|
			format.html
			format.json { render json: @announces }
		end
	end
end
