task analyse: :environment do
  Email.all.each do |email|
    unless email.tracked == true
      recipient = email.recipient
      dictionary = recipient.dictionary
      subject = email.subject

      subject.each do |word|
        if dictionary[word] == nil
          dictionary[word] = 1
        else
          dictionary[word] = dictionary[word] + 1
        end
      end

      recipient.dictionary = dictionary
      recipient.save

      email.tracked = true
      email.save
    end
  end
end
