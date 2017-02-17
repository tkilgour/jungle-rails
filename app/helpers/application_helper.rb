module ApplicationHelper
  def star_rating(rating)
    star_rating = ''
    rating.times { star_rating << (fa_icon 'star') }
    (5-rating).times { star_rating << (fa_icon 'star-o') }
    star_rating.html_safe
  end
end
