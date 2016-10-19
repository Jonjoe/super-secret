require "json"

file = File.join(Rails.root, 'public', 'data', 'mini.json')

File.open(file, 'r').each do |file|
  json = JSON.parse(file)['uploads']
  total_users = json.count
  total_users_counter = 0

  puts "=== Total users = #{total_users}"

  json.each do |item|
    total_users_counter = total_users_counter + 1
    item["emails"].each do |email|

      # Create! new email instance per recipient.
      email["recipients"].each do |recipient|

        # Log the recipient if its not already in the system
        recipient = Recipient.find_or_initialize_by(
          email_address:recipient
        )

        recipient.save

        # Create! the email record
        recipient.emails.create(
          subject: email["subject"].split(" "),
          sent_on: email["timestamp"]
        )

      end # end of recipient loop
    end # end of emails loop

    puts "Completed #{total_users_counter} of #{total_users}"
  end
end