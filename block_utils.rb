require 'time'

  def build_title_block(title, link, timestamp)
    return { type: "section", text: { type: "mrkdwn", text: ":triangular_flag_on_post:\n<#{link}|#{title}> (#{timestamp})" }}
  end
  
  def build_update_block(update_hash)
    status = update_hash["status"]
    timestamp = format_time(update_hash["updated_at"])
    description = update_hash["body"]
    return { type: "section", text: { type: "mrkdwn", text: "*#{status}*\n#{timestamp}\n#{description}"}}
  end

  def build_divider_block()
    return {type: "divider"}
  end
  
  def format_time(timestamp)
    return Time.parse(timestamp).strftime("%b %-d %H:%M %Z")
  end
