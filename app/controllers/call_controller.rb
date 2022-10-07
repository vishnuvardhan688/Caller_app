class CallController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :ensure_user_logged_in
  # before_action :current_account

  def connect
    # puts "AS: #{params[:phone_number]}"
    render xml: twilio_reponse
  end

  def record_call
    @client = Twilio::REST::Client.new($current_account.account_sid, $current_account.auth_token)
    call = @client.calls($call_sid).fetch()
    puts call.inspect
    new_call = Call.new(
      account_id: $current_account.id,
      user_id: $current_user.id,
      duration: call.duration,
      from: $current_account.phone_number,
      to_phone_number: $to,
      status: call.status,
      start_time: call.start_time,
      end_time: call.end_time,
    )
    new_call.save
    message = @client.messages
      .create(
        from: $current_account.phone_number,
        body: "From: #{$current_account.phone_number}, To: #{$to}, Duration: #{call.duration} sec, Price: $ #{call.duration.to_i * 0.5}",
        to: $to,
      )
  end

  private

  def twilio_reponse
    # @current_account = ApplicationController.current_account
    # puts "sessio: #{session[:current_account_id]}"
    # @current_account = Account.find(session[:current_account_id])
    # @client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
    # call = @client.calls("CAe3205503afdeb3dd1fd838e758f0fb9c").fetch()
    # puts call
    # curr = current_account
    # puts "curr: #{$current_account.id}"
    twilio_number = $current_account.phone_number #ENV["TWILIO_PHONE_NUMBER"]

    res = Twilio::TwiML::VoiceResponse.new do |response|
      dial = Twilio::TwiML::Dial.new caller_id: twilio_number

      if params.include?(:phoneNumber)
        dial.number params[:phoneNumber]
      else
        dial.client(identity: "support_agent")
      end
      response.append(dial)
    end
    $call_sid = params[:CallSid]
    $to = params[:phoneNumber]
    # account_sid = current_account.account_sid
    # auth_token = current_account.auth_token
    # @client = Twilio::REST::Client.new($current_account.account_sid, $current_account.auth_token)

    # message = @client.messages
    #   .create(
    #     from: $current_account.phone_number,
    #     body: "From: #{$current_account.phone_number}, To: #{params[:phoneNumber]} call ended",
    #     # messaging_service_sid: "MG9752274e9e519418a7406176694466fa",
    #     to: params[:phoneNumber],
    # )
    puts "res: #{res}"
    return res.to_s
  end
end
