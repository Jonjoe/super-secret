class Recipient < ApplicationRecord
  has_many :emails

  def top_words(max)
    return $raw.sort_by(&:last).reverse[0...max]
  end

  def unique_words
    return $raw.find_all{|key,value|value == 1}
  end

  def recieved_this_month
    return self
      .emails
      .where(
        " sent_on > ? AND sent_on < ?",
        Time.now.beginning_of_month,
        Time.now.end_of_month
      )
      .count
  end

  private
  def raw_dictionary
    forbidden_values = [
      "-",
      "?",
      "!",
      "£",
      "$",
      "|",
      "'",
      "/",
    ]

    $raw = self.dictionary

    forbidden_values.each do |item|
      $raw.delete(item)
    end
  end
end