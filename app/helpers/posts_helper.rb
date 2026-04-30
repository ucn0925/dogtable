module PostsHelper
  def visit_scene_icon(scene)
    case scene
    when "lunch"
      content_tag(:i, "", class: "fa-solid fa-sun")
    when "cafe"
      content_tag(:i, "", class: "fa-solid fa-mug-hot")
    when "dinner"
      content_tag(:i, "", class: "fa-solid fa-moon")
    end
  end
end