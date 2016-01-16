# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->
  robot.hear /hello/i, (res) ->
    res.send "hello there #{res.message.user.id}"

  robot.router.get '/almostthere', (req, res) ->
    url = ['https:/',req.headers.host,'sms/receive'].join('/')
    res.send "Last step: configure your Twilio to callback to Concierge using #{url}"

  robot.router.post '/sms/receive', (req, res) ->
    message = req.body

    robot.emit 'telegram:invoke', 'sendMessage',
      chat_id: '131894509'
      text: "💬 *#{message.From}*\n#{message.Body}"
      parse_mode: 'Markdown'
    , (error, response) =>
      console.log(error);
      console.log(response);
    
    res.send 'OK'
