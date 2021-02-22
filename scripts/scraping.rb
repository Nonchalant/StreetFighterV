require 'dotenv'
require 'google_drive'
require 'nokogiri'
require 'open-uri'
require_relative 'config.rb'

Dotenv.load

# ja or en
language = ARGV[0].nil? ? "ja" : ARGV[0]

cookie = "scirid=#{ENV["SCIRID"]}; vmial=#{ENV["VMIAL"]}; notification_ja=#{ENV["NOTIFICATION_JA"]}; notification_en=#{ENV["NOTIFICATION_EN"]}; language=#{language}"
session = GoogleDrive::Session.from_config("config.json")

sp = session.spreadsheet_by_url(ENV["SPREADSHEET_#{language.upcase}"])
characters_ws = sp.worksheet_by_title("キャラクター")

CHARACTERS.each do |character|
  print "#{character["sheet_title"]} (#{language}): Start..."

  if character['url'].nil?
    url = character["url_#{language}"]
  else
    url = character['url']
  end

  triggers = []

  character['tables'].each do |table|
    charset = nil
    html = open("https://game.capcom.com/cfn/sfv/character/#{url}/frame/table/#{table}", "Cookie" => cookie) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)

    frameTbls = doc.css('.frameTbl')

    if frameTbls.empty?
      puts "Cookie Expired"
      exit 1
    end

    _triggers = []
    currentTab = doc.css('.current').text

    frameTbls.each do |frameTbl|
      if currentTab.empty? || currentTab.nil?
        # VT1
        trigger = frameTbl.attribute('vtrigger').text
      else
        # VT1(爪あり)
        trigger = "#{frameTbl.attribute('vtrigger').text}(#{currentTab})"
      end

      moves = []
      type = ""

      frameTbl.css('tr').each do |tr|
        ths = tr.css('th')

        if ths.length > 0 && ths[0].attribute('class').text == 'type'
          type = ths[0].text.strip
          next
        end

        tds = tr.css('td')

        if tds.empty?
          next
        end

        move = ["VT#{trigger}", type]

        # 技名
        move.push(tds[0].css('p')[0].text)

        # 技名 ~ Vキャン硬直差(ガード)
        7.times do |i|
          move.push(tds[i + 1].text.split('\n')[0])
        end

        # 備考
        move.push(tds[tds.length - 1].text.strip.gsub(/\n\s+/, "\n"))

        moves.push(move)
      end

      if trigger.slice(0) == "1"
        _triggers = moves + _triggers
      else
        _triggers += moves
      end
    end

    triggers += _triggers
  end

  sheet_title = characters_ws.rows
    .select { |row| row[0] == character["sheet_title"] }
    .first[1]

  ws = sp.worksheet_by_title(sheet_title)
  ws.update_cells(2, 1, triggers)
  ws.save()

  puts "Done"
end
