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

# Used to fill ckeditor fields
# @param [String] locator label text for the textarea or textarea id
def fill_in_ckeditor(locator, options)
  locator = find_field_by_label(locator)
  # Fill the editor content
  page.execute_script <<-SCRIPT
    var ckeditor = CKEDITOR.instances.#{locator}
    ckeditor.setData('#{ActionController::Base.helpers.j options[:with]}')
    ckeditor.focus()
    ckeditor.updateElement()
  SCRIPT
end

def fill_in_autocomplete(field, options = {})
  field = find_field_by_label(field)
  fill_in field, with: options[:with]

  page.execute_script "$('##{field}').trigger('focus')"
  page.execute_script "$('##{field}').trigger('keydown')"
  selector = %{.tt-menu .tt-suggestion:contains("#{options[:with]}")}

  page.should have_selector('.tt-menu .tt-suggestion')
  page.execute_script "$('#{selector}').trigger('mouseenter').click()"
end

def find_field_by_label(locator)
  if page.has_css?('label', text: locator)
    find('label', text: locator)[:for]
  else
    locator
  end
end
