# frozen_string_literal: true

def path_to_url(path)
  protocol = request.protocol
  host = request.host_with_port.sub(/:80$/, '')
  stripped_path = path.sub(%r{^/}, '')
  "#{protocol}#{host}/#{stripped_path}"
end

def show_page
  save_page Rails.root.join('public', 'capybara.html')
  # This runs launchy as a system command
  `launchy http://localhost:3000/capybara.html`
end

def wait_until(delay = 1)
  seconds_waited = 0
  while !yield && seconds_waited < Capybara.default_max_wait_time
    sleep delay
    seconds_waited += 1
  end
  unless yield
    puts "Waited for #{Capybara.default_max_wait_time} seconds."
    puts "{#{yield}} did not become true, continuing."
  end
end

def submit_via_execute(form_selector)
  page.execute_script("$('#{form_selector}').submit();")
end

def click_on_body
  page.execute_script("$('body').click();")
end

# Used to fill wysiwig fields
# @param [String] locator label text for the textarea or textarea id
def fill_in_wysiwyg(locator, text)
  include ActionView::Helpers::JavaScriptHelper
  locator = find_field_by_label(locator)
  text = text.tr("'", "\'").gsub("\n", '\\\n')

  # Fill the editor content
  page.execute_script <<-SCRIPT
    $('##{locator}').data('wysihtml5').editor.setValue('#{text}');
  SCRIPT
end

def find_field_by_label(locator)
  if page.has_css?('label', text: locator)
    find('label', text: locator)[:for]
  else
    locator
  end
end
