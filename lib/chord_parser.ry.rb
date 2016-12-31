class ChordParser
options no_result_var

rule
  body      : sections
              { val[0] }

  sections  : section
              { [ val[0] ]  }
            | sections section
              { val[0] << val[1] }

  separator : SEPARATOR

  br        : BREAKLINE
            | br BREAKLINE

  section   : title measures br
              { { title: val[0], measures: val[1]} }

  title     : TITLE
              { val[0] }

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

  chord     : CHORD
              { { name: val[0], sounds: nil } }
            | chord SOUNDS
              { val[0][:sounds] = val[1]; val[0] }
end

---- header

require 'strscan'

---- inner

R_SEPARATOR  = /\A\|/
R_SPACE      = /\A[\s]+/
R_BREAKLINE  = /\A[\r\n]+/
R_CHORD      = /\A([^|\n\r{}]+)(?:\{([0-9a-nx]{6})\})?/
# R_SOUNDS     = /\A{([0-9a-cn]{6})}/
R_TITLE      = /\A([^:\n\r]+):(\r\n|\r|\n)/

attr_reader :src
attr_reader :q

def initialize(obj)
  @src = obj.is_a?(IO) ? obj.read : obj.to_s + "\n"
  @yydebug = ENV['YYDEBUG'] ? true : false
end

def parse
  piece = nil
  @s = StringScanner.new(src)
  @q = []

  until @s.eos?
    if (piece = @s.scan R_TITLE)
      m = piece.match(R_TITLE)
      @q << [:TITLE, m[1].strip]
    elsif(piece = @s.scan R_SEPARATOR)
      @q << [:SEPARATOR, nil]
    elsif (piece = @s.scan R_BREAKLINE)
      @q << [:BREAKLINE, nil]
    elsif (piece = @s.scan R_SPACE)
    elsif (piece = @s.scan R_CHORD)
      m = piece.match(R_CHORD)
      @q << [:CHORD, m[1].strip]
      @q << [:SOUNDS, m[2]] if m[2]
    else
      raise "Error at #{@s.pos} \"#{src[@s.pos]}\""
    end
  end

  do_parse
end

def next_token
  @q.shift
end

