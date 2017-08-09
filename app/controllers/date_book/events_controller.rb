# frozen_string_literal: true

module DateBook
  # Allows viewing and maintaining Events within Calendars
  class EventsController < DateBookController
    load_and_authorize_resource :calendar, find_by: :slug
    load_and_authorize_resource :event, find_by: :slug, through: :calendar
    before_action :set_occurrence, only: %i[show popover]

    # GET /events
    def index
      start_date = params[:start]&.to_datetime || Time
                   .now
                   .beginning_of_month
      end_date   = params[:end]&.to_datetime || Time
                   .now
                   .beginning_of_month
                   .next_month
      @events = @events&.ending_after(start_date)&.starting_before(end_date)
    end

    # GET /events/slug
    def show; end

    # GET /events/slug/popover
    def popover
      render layout: 'blank'
    end

    # GET /events/new
    def new; end

    # GET /events/slug/edit
    def edit; end

    # POST /events
    def create
      @event.owners = [current_user]
      unless @event.save
        flash[:error] = @event.errors.full_messages.to_sentence
        render :new
        return
      end
      redirect_to([@calendar, @event], notice: :item_acted_on.l(
        item: Event.model_name.human,
        action: :created.l
      ))
    end

    # PATCH/PUT /events/slug
    def update
      unless @event.update(event_params)
        flash[:error] = @event.errors.full_messages.to_sentence
        render :edit
        return
      end
      redirect_to([@calendar, @event], notice: :item_acted_on.l(
        item: Event.model_name.human,
        action: :updated.l
      ))
    end

    # DELETE /events/slug
    def destroy
      @event.destroy
      redirect_to(
        calendar_events_url(@calendar),
        notice: :item_acted_on.l(
          item: Event.model_name.human,
          action: :destroyed.l
        )
      )
    end

    private

    def set_occurrence
      return unless params[:occurrence_id].present?
      @occurrence = @event.event_occurrences.find(params[:occurrence_id])
    end

    # Only allow a trusted parameter "white list" through.
    # rubocop:disable Metrics/MethodLength
    def event_params
      schedule_attributes = [
        :id, :date, :time, :rule, :until, :count, :interval, :all_day,
        {
          day: [],
          day_of_week: [
            {
              monday: [], tuesday: [], wednesday: [], thursday: [],
              friday: [], saturday: [], sunday: []
            }
          ],
          duration_attributes: %i[count unit]
        }
      ]

      params.require(:event).permit(
        :id, :name, :description, :css_class, :text_color, :background_color,
        :border_color, schedule_attributes: schedule_attributes
      )
    end
  end
  # rubocop:enable Metrics/MethodLength
end
