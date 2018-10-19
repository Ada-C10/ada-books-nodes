module ApplicationHelper
  def readable_date(date)
    ("<span class='date'>" + date.strftime("%A, %b %d") + "</span>").html_safe
  end
  def random_image(width, height)
    number = rand(3)
    url = ""
    case number
    when 0
      url = "https://picsum.photos/"
    when 1
      url = "http://www.placecage.com/"
    when 2
      url = "http://placekitten.com/"
    end
    ["<img src='", url, width,"/" ,height, "' alt='random image'>"].join.html_safe
  end
end
