module Base62
  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  def self.encode(number)
    return CHARACTERS[0] if number.eql?(0)

    base = CHARACTERS.length
    result = []

    until number.zero?
      result << CHARACTERS[number % base]
      number /= base
    end

    result.reverse.join
  end
end
