# frozen_string_literal: true

# Replaces 2-letter US state codes in a string with the full state name.
# Example: replace_state_codes('I live in CA and NY.') => 'I live in California and New York.'
module DiscourseSyncToCustomField
  module ReplaceStateCodes
    STATE_CODES = {
      "AL" => "Alabama",
      "AK" => "Alaska",
      "AZ" => "Arizona",
      "AR" => "Arkansas",
      "CA" => "California",
      "CO" => "Colorado",
      "CT" => "Connecticut",
      "DE" => "Delaware",
      "FL" => "Florida",
      "GA" => "Georgia",
      "HI" => "Hawaii",
      "ID" => "Idaho",
      "IL" => "Illinois",
      "IN" => "Indiana",
      "IA" => "Iowa",
      "KS" => "Kansas",
      "KY" => "Kentucky",
      "LA" => "Louisiana",
      "ME" => "Maine",
      "MD" => "Maryland",
      "MA" => "Massachusetts",
      "MI" => "Michigan",
      "MN" => "Minnesota",
      "MS" => "Mississippi",
      "MO" => "Missouri",
      "MT" => "Montana",
      "NE" => "Nebraska",
      "NV" => "Nevada",
      "NH" => "New Hampshire",
      "NJ" => "New Jersey",
      "NM" => "New Mexico",
      "NY" => "New York",
      "NC" => "North Carolina",
      "ND" => "North Dakota",
      "OH" => "Ohio",
      "OK" => "Oklahoma",
      "OR" => "Oregon",
      "PA" => "Pennsylvania",
      "RI" => "Rhode Island",
      "SC" => "South Carolina",
      "SD" => "South Dakota",
      "TN" => "Tennessee",
      "TX" => "Texas",
      "UT" => "Utah",
      "VT" => "Vermont",
      "VA" => "Virginia",
      "WA" => "Washington",
      "WV" => "West Virginia",
      "WI" => "Wisconsin",
      "WY" => "Wyoming",
      "DC" => "District of Columbia",
      "AS" => "American Samoa",
      "GU" => "Guam",
      "MP" => "Northern Mariana Islands",
      "PR" => "Puerto Rico",
      "VI" => "U.S. Virgin Islands",
      "UM" => "U.S. Minor Outlying Islands",
      # Canadian Provinces and Territories
      "AB" => "Alberta",
      "BC" => "British Columbia",
      "MB" => "Manitoba",
      "NB" => "New Brunswick",
      "NL" => "Newfoundland and Labrador",
      "NS" => "Nova Scotia",
      "ON" => "Ontario",
      "PE" => "Prince Edward Island",
      "QC" => "Quebec",
      "SK" => "Saskatchewan",
      "NT" => "Northwest Territories",
      "NU" => "Nunavut",
      "YT" => "Yukon",
    }

    # Replaces all 2-letter state codes in the input string with full state names
    def self.replace_state_codes(text)
      return text unless text.is_a?(String)
      text.gsub(/\b([A-Z]{2})\b/) { |code| STATE_CODES[code] || code }
    end
  end
end
