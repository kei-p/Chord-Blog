class ChordParser
options no_result_var

rule
  body      : sections
              { val[0] }

  ws        :
            | ws SPACE

  br        : ws BREAKLINE ws
            | br ws BREAKLINE ws

  sections  : section
              { [ val[0] ]  }
            | sections section
              { val[0] << val[1] }

  separator : ws SEPARATOR ws

  section   : title measures br
              { { title: val[0], measures: val[1]} }

  title     : TITLE
              { val[0].strip }

  measures  : chords
              { [ val[0] ] }
            | measures separator chords
              { val[0] << val[2]  }
            | measures br chords
              { val[0] << val[2]  }

  chords    : chord
              { [val[0]] }
            | chords chord
              { val[0] << val[1] }

  chord     : ws CHORD ws
              { val[1] }
end

---- header

require 'strscan'

---- inner

R_SEPARATOR  = /\A\|/
R_SPACE      = /\A[ ]+/
R_BREAKLINE  = /\A\n/
R_CHORD      = /\A[A-Ga-g][b#]?[Mm769]*(\([#b\d]+\))?/
R_TITLE      = /\A([^:\n\r]+):\n/

attr_reader :src
attr_reader :q

def initialize(obj)
  @src = obj.is_a?(IO) ? obj.read : obj.to_s
  @yydebug = ENV['YYDEBUG'] ? true : false
end

def parse
  piece = nil
  @s = StringScanner.new(src)
  @q = []

  until @s.eos?
    if (piece = @s.scan R_TITLE)
      m = piece.match(R_TITLE)
      @q << [:TITLE, m[1]]
    elsif(piece = @s.scan R_SEPARATOR)
      @q << [:SEPARATOR, piece]
    elsif (piece = @s.scan R_SPACE)
      @q << [:SPACE, piece]
    elsif (piece = @s.scan R_BREAKLINE)
      @q << [:BREAKLINE, piece]
    elsif (piece = @s.scan R_CHORD)
      @q << [:CHORD, piece]
    else
      raise "Error at #{@s.pos} \"#{src[@s.pos]}\""
    end
  end

  do_parse
end

def next_token
  @q.shift
end

