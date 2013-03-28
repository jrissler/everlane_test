require 'rubygems'

class String
  def valid_message_format?(valid_count = nil)
    case self
      when valid_count == 2
        true
      when /^[a-j].+/
        false
      when /Z.a{0}/
        return true if self.size == 2 && self =~ /[a-j]$/
        self.split(/Z/).size == 3 ? self.split(/Z.a{0}/).join('').valid_message_format?(valid_count = 2) : self.gsub(/Z.a{0}/, '').valid_message_format?(valid_count = 1)
      when /^[MKPQ]/
        self.size == 3 || valid_count ? true : false
      when /^[a-j]/
        true
      else
        false
    end
  end
end

invalid = ['Qa', 'Khfa', 'M', 'aa', 'ZZ']
valid   = ['a', 'Zj', 'MZca', 'MZaZa', 'Maa']

(invalid + valid).each do |i|
  puts [i, 'returns', i.valid_message_format?].join(' ')
end

#* Output *#
# /Users/James/.rvm/rubies/ruby-1.9.3-p392/bin/ruby -e $stdout.sync=true;$stderr.sync=true;load($0=ARGV.shift) /Users/James/Code/everlane_test/everlane.rb
# Qa returns false
# Khfa returns false
# M returns false
# aa returns false
# ZZ returns false
# a returns true
# Zj returns true
# MZca returns true
# MZaZa returns true
# Maa returns true
#
# Process finished with exit code 0