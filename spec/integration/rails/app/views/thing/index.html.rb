# -*- encoding : utf-8 -*-
class Views::Thing::Index < Garterbelt::View
  def content
    text 'foo '
    text 'bar'
  end
end
