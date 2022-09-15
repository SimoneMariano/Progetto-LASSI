require 'google/apis/gmail_v1'

class TicketMailerController < ApplicationController

    def new
    end


    def send_email

        to = params[:to]

        if User.find_by(email: to).blank?
            flash[:alert] = "There aren't a students signed up to BiblioCommunity with this email"
        else

            from = params[:from]
            subject = params[:subject]
            body = params[:mail_body]

            service = Google::Apis::GmailV1::GmailService.new
            service.authorization = session[:access_token]
            service.key = Rails.application.credentials.dig(:gmail_key)

            message              = Mail.new
            message.date         = Time.now
            message.subject      = '[BiblioCommunity] help: '+subject
            message.body         = "<p>"+body+"</p>"
            message.content_type = 'text/html'
            message.from         = from
            message.to           = to

            msg = message.encoded
            message_object = Google::Apis::GmailV1::Message.new(raw:message.to_s)

            if service.send_user_message(from, message_object)
                flash[:notice] = "Your email has been successfully sent"            
            end
        end
        
        redirect_by_request_type(new_mail_url)
      
    end

    def redirect_by_request_type(url)
        if request.xhr?
          render js: "window.location='#{url}'"
        else
          redirect_to url, status: 303, turbolinks: false
        end
    end

    rescue_from Google::Apis::ClientError do |exception|
        flash[:alert] = "Error with mail submit"
        redirect_by_request_type(new_mail_url)
    end

end
