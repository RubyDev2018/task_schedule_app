module TasksHelper
  def finish_or_unfinish_link(task)
    if task.done?
      link_to('戻す', [ :unfinish, task ], :method => :put)
    else
      link_to('完了', [ :finish, task ], :method => :put)
    end
  end

  def navigation_links_tasks
   items = []
   items << link_or_text('未完了タスク', :tasks)
   items << link_or_text('完了したタスク', [ :done, :tasks ])
   content_tag(:ul, :class => 'navigation') { items.join.html_safe }
  end

  def navigation_links
   items = []
   items << link_or_text('未完了タスク', :user)
   items << link_or_text('完了したタスク', [ :done, :user ])
   content_tag(:ul, :class => 'navigation') { items.join.html_safe }
  end

  private
    def link_or_text(text, resource)
      html_class = current_page?(resource) ? 'selected' : nil
      content_tag(:li, :class => html_class) do
        link_to_unless_current(text, resource)
      end
    end
end
