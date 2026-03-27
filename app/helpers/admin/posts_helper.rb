module Admin::PostsHelper
  def empty_posts_message(filter)
    case filter
    when "draft" then "Nenhum rascunho encontrado."
    when "published" then "Nenhum post publicado ainda."
    when "newsletter" then "Nenhum post marcado para newsletter."
    else "Nenhum post criado ainda."
    end
  end
end
