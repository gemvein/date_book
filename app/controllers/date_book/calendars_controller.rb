module DateBook
  class CalendarsController < DateBookController
    #TODO: Make this a real resource

    # GET /calendar
    def show
      ending_after = params.fetch(:ending_after, Date.today.at_beginning_of_month)
      starting_before = params.fetch(:starting_before, Date.today.at_beginning_of_month.next_month)

      @events = Event.accessible_by(current_ability).ending_after(ending_after).starting_before(starting_before)
    end
  end
end
