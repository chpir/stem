class AnalysisController < ApplicationController

  def index
  end

  def stem
    h = Hash.new
    f = params[:str].split("\n")
    f.each do |line|
      words = line.gsub('"','').gsub(/[^a-z0-9\s]/i, ' ').gsub(/ {2,}/,' ').split(' ')
      words.each do |w|
        w = w.downcase.stem
        next if w == ""
        if h.has_key?(w)
          h[w] = h[w] + 1
        else
          h[w] = 1
        end
      end

    end


    out = ""
    h.sort{|a,b| b[1]<=>a[1]}.each do |elem|
      out << "\"#{elem[0]}\" has #{elem[1]} occurrences\n"
    end

    render :update do |page|
      page.replace_html 'results', out
    end

  end

end
