class Parcel 
    # regex composed of a prefix, section and plan
    # prefix optional with 3 digits
    # section with 1 or 2 uppercase letters or 2 digits
    # plan with 4 digits (mandatory if section is composed of digits) or 1-4 digits
    # optional leading zeros for section : https://ruby-doc.org/core-3.1.2/Regexp.html#class-Regexp-label-Grouping 
    NUMBER_REGEXP = /\A(?:(?<prefix>\d{3})[ ])?(?!\d{2}[ ]\d{1,3}\z)(?:0*)(?<section>[A-Z]{1,2}|\d{2})[ ](?<plan>\d{1,4})\z/
end