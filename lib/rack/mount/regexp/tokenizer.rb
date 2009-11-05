#--
# DO NOT MODIFY!!!!
# This file is automatically generated by rex 1.0.4
# from lexical definition file "lib/rack/mount/regexp/tokenizer.rex".
#++

require 'racc/parser'
module Rack::Mount
class RegexpParser < Racc::Parser
  require 'strscan'

  class ScanError < StandardError ; end

  attr_reader   :lineno
  attr_reader   :filename
  attr_accessor :state

  def scan_setup(str)
    @ss = StringScanner.new(str)
    @lineno =  1
    @state  = nil
  end

  def action(&block)
    yield
  end

  def scan_str(str)
    scan_setup(str)
    do_parse
  end

  def load_file( filename )
    @filename = filename
    open(filename, "r") do |f|
      scan_setup(f.read)
    end
  end

  def scan_file( filename )
    load_file(filename)
    do_parse
  end


  def next_token
    return if @ss.eos?

    text = @ss.peek(1)
    @lineno  +=  1  if text == "\n"
    token = case @state
    when nil
      case
      when (text = @ss.scan(/<(\w+)>/))
         action { [:NAME, @ss[1]] }

      when (text = @ss.scan(/\(/))
         action { [:LPAREN,  text] }

      when (text = @ss.scan(/\)/))
         action { [:RPAREN,  text] }

      when (text = @ss.scan(/\?/))
         action { [:QMARK, text] }

      when (text = @ss.scan(/\+/))
         action { [:PLUS,  text] }

      when (text = @ss.scan(/\*/))
         action { [:STAR,  text] }

      when (text = @ss.scan(/\:/))
         action { [:COLON, text] }

      when (text = @ss.scan(/\\(.)/))
         action { [:CHAR, @ss[1]] }

      when (text = @ss.scan(/./))
         action { [:CHAR, text] }

      else
        text = @ss.string[@ss.pos .. -1]
        raise  ScanError, "can not match: '" + text + "'"
      end  # if

    else
      raise  ScanError, "undefined state: '" + state.to_s + "'"
    end  # case state
    token
  end  # def next_token

end # class
end # module
