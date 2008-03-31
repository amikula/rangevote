# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def range_color_for(value)
    if value == "X"
      return "#ffffff"
    end

    if value<=49
      red=255
    else
      red=((99-value)*(255/50.0)).floor
    end

    if value<=49
      green=(value*(255/49.0)).floor
    else
      green=255
    end

    blue = ((49 - (49-value).abs)*255/49.0).floor
    blue = 0 if (blue < 0)

    return "#" + ("%02x"%red) + ("%02x"%green) + ("%02x"%blue);
  end
end
