module MarkupHelper
  def chunk(s)
    chunks = []
    working = []
    list = nil
    table = false
    s.each_line { |line|
      line.chomp!
      # headings
      if line =~ /^(=+|-+)$/ and working.length > 0
        chunks << working
        chunks << [:heading, chunks[-1].pop, line]
        working = []
      elsif line =~ /^#+\s\S/
        chunks << working
        chunks << [:heading, line]
        working = []
      # horizontal line
      elsif line =~ /^\s*([-*])\s?\1\s?\1\s*$/
        chunks << working
        chunks << [:hr, line]
        working = []
      # paragraphs
      elsif line.strip == ""
        chunks << working
        working = []
      # lists - chunk based on first level one
      elsif line =~ /^\s*[+*-](\s|$)/
        if list != :unordered and line =~ /^\S/
          chunks << working
          working = [:list]
        end
        working << line
        list = :unordered unless line =~ /^\s/
      elsif line =~ /^\s*[a-zA-Z0-9]\.(\s|$)/
        if list != :ordered and line =~ /^\S/
          chunks << working
          working = [:list]
        end
        working << line
        list = :ordered unless line =~ /^\s/
      elsif line =~ /^\|.*\|$/
        if !table
          chunks << working
          working = [:table]
        end
        working << line.split('|')
        table = true
      else
        if list or table
          chunks << working
          working = []
          list = nil
          table = false
        end
        if working.empty?
          working << :paragraph
        end
        working << line
      end
    }
    chunks << working
    chunks.delete_if {|item| item.size <= 1}
  end

  # adds some formatting to text
  def parse(s)
    s = h(s)
    s.gsub!(/(?<!\\)((?:\\\\)*)\[(.*?(?<!\\)(?:\\\\)*)\]\((.*?)\)/, '\1<a href="\3">\2</a>')
    escape = false
    tag = false
    strong = false
    emphasise = false
    underline = false
    mono = false
    s = s.split(//).map { |c|
      if c == '>'
        tag = false
        next c
      elsif c == '<'
        tag = true
        next c
      elsif tag
        next c
      elsif escape
        escape = false
        next c
      elsif c == '\\'
        escape = true
        next nil
      elsif c == '*'
        # var = !var returns !var along with toggling var
        next '<strong>' if strong = !strong
        next '</strong>' # if otherwise
      elsif c == '/'
        next '<em>' if emphasise = !emphasise
        next '</em>'
      elsif c == '_'
        next '<u>' if underline = !underline
        next '</u>'
      elsif c == '`'
        next '<code>' if mono = !mono
        next '</code>'
      else
        next c
      end
    }.join
    s.sub!(/(.*)<strong>/, '\1*') if strong
    s.sub!(/(.*)<em>/, '\1/') if emphasise
    s.sub!(/(.*)<u>/, '\1_') if underline
    s.sub!(/(.*)<code>/, '\1`') if mono
    s += '\\' if escape
    s
  end

  def driver
    text = "*bold* _underline_ and /emphasised/"
    puts parse(text)
  end


  def add_tags(items)
    items.map do |item|
      # Headings
      if item.first == :heading
        if item.size == 2
          head, line = item[1].split(' ', 2)
          "<h#{head.size}>" + parse(line) + "</h#{head.size}>"
        else
          if item[2][0] == '='
            "<h1>" + parse(item[1]) + "</h1>"
          else
            "<h2>" + parse(item[1]) + "</h2>"
          end
        end
      elsif item.first == :hr
        "<hr>"
      elsif item.first == :paragraph
        "<p>" + item[1..-1].map {|i| parse i }.join("<br>\n") + "</p>"
      elsif item.first == :list
        depth = -1
        list = []
        item[1..-1].map {|line|
          res = ''
          cdepth = line.length - line.lstrip.length
          if cdepth > depth
            depth = cdepth
            if line =~ /^\s*[+*-]/
              res += "<ul>\n" 
              list << "</ul>\n"
            elsif line =~ /^\s*[a-zA-Z0-9]\./
              res += "<ol>\n"
              list << "</ol>\n"
            end
          elsif cdepth < depth
            depth = cdepth
            res += list.pop
          end
          res + "<li>" + parse(line.lstrip.sub(/^([+*-]|[a-zA-Z0-9]\.)\s/, '')) + "</li>"
        }.join("\n") + "\n" + list.reverse.join("\n")
      elsif item.first == :table
        "<table class='table'>\n<tr>\n<td>" +
        item[1..-1].chunk {|row| row.all? {|s| s =~ /^-*$/ } }.map { |border, ary|
          if border
            "</td>\n</tr>\n<tr>\n<td>"
          else
            ary[0].zip(*ary[1..-1])[1..-1].map{ |line|
              mrkup line.join("\n")
            }.join("</td>\n<td>")
          end
        }.join +
        "</td>\n</tr>\n</table>"
      else
        item.to_s
      end
    end
  end


  def mrkup(s)
    #markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true)
    #return markdown.render(h(s))
    # remove escaped newlines
    s.gsub!(/(?<!\\)((?:\\\\)*)\\\r?\n/, '\1')
    # first chunk the sections, then parse each
    chunk(s).map {|item|
      if item[0] == :heading
        if item.size == 2
          head, line = item[1].split(' ', 2)
          "<h#{head.size+1}>" + parse(line) + "</h#{head.size+1}>"
        else
          if item[2][0] == '='
            "<h2>" + parse(item[1]) + "</h2>"
          else
            "<h3>" + parse(item[1]) + "</h3>"
          end
        end
      elsif item[0] == :hr
        "<hr>"
      elsif item[0] == :paragraph
        "<p>" + item[1..-1].map {|i| parse i }.join("<br>\n") + "</p>"
      elsif item[0] == :list
        depth = -1
        list = []
        item[1..-1].map {|line|
          res = ''
          cdepth = line.length - line.lstrip.length
          if cdepth > depth
            depth = cdepth
            if line =~ /^\s*[+*-]/
              res += "<ul>\n" 
              list << "</ul>\n"
            elsif line =~ /^\s*[a-zA-Z0-9]\./
              res += "<ol>\n"
              list << "</ol>\n"
            end
          elsif cdepth < depth
            depth = cdepth
            res += list.pop
          end
          res + "<li>" + parse(line.lstrip.sub(/^([+*-]|[a-zA-Z0-9]\.)\s/, '')) + "</li>"
        }.join("\n") + "\n" + list.reverse.join("\n")
      elsif item[0] == :table
        "<table class='table'>\n<tr>\n<td>" +
        item[1..-1].chunk {|row| row.all? {|s| s =~ /^-*$/ } }.map { |border, ary|
          if border
            "</td>\n</tr>\n<tr>\n<td>"
          else
            ary[0].zip(*ary[1..-1])[1..-1].map{ |line|
              mrkup line.join("\n")
            }.join("</td>\n<td>")
          end
        }.join +
        "</td>\n</tr>\n</table>"
      else
        item.to_s
      end
    }.join("\n")
  end
end
