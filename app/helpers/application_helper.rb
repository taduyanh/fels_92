module ApplicationHelper
  def title page_title
    content_for(:title) { page_title }
  end

  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def user_avatar_from_activity activity
    activity.user.avatar.nil? ? '' : activity.user.avatar.url
  end

  def activity_title activity
    t('users.index.activity_title', words: activity.lesson_words.correct_words.count,
      category: activity.category.name, lesson_created_at: activity.created_at)
  end
end
